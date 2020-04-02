VARS=-var "env_var=${env_var}" -var "ec2_public_ip=${ec2_public_ip}" -var "docker_image_uri=${docker_image_uri}"

deploy-service:
	terraform init
	terraform apply ${VARS} 