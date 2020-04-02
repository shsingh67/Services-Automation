
resource "null_resource" "prov_service" {

    connection {
        type = "ssh"
        host = "${var.ec2_public_ip}"
        user = "ubuntu"
        private_key = file("~/.ssh/${var.key_name}.pem")
    }

    provisioner "remote-exec" {
        inline = [
            "aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin 499457313268.dkr.ecr.us-west-1.amazonaws.com/hotels-search-service",
            "docker pull ${var.docker_image_uri}",
            "docker run -it -p8080:8080 ${var.env_var} ${var.docker_image_uri}"
        ]
    }
  
}