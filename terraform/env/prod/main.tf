provider "aws" {
    profile = var.profile
    region = var.region
}

resource "aws_instance" "linux_internal_ec2" {
    ami = var.ami
    key_name = var.key_name
    instance_type = var.instance_type
    security_groups = ["${aws_security_group.sg_ec2.name}"]

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/${var.key_name}.pem")
        host = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update",
            "sudo apt install docker.io -y",
            "sudo systemctl start docker",
            "sudo systemctl enable docker",
            "apt get install unzip",
            "curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip",
            "unzip awscliv2.zip",
            "sudo ./aws/install"
        ]
    }

    provisioner "local-exec" {
        command = <<EOF
            "scp -i ~/.ssh/${var.key_name}.pem -r ~/.aws  ubuntu@${self.public_ip}:~"
        EOF
    }

    tags = {
        Name = "prod_deploy"
    }
}

resource "aws_security_group" "sg_ec2" {

    name = "prod_deploy"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

