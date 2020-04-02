output "ec2_public_ip" {
    value = aws_instance.linux_internal_ec2.public_ip
}