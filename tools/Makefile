ifdef DEPLOYMENT
	DIRECTORY=dev
else
	DIRECTORY=prod
endif

init-ec2:
	cd ../terraform/env/${DIRECTORY} && make init-ec2 

deploy-service:
ifndef ec2_public_ip
	$(error EC2 public ip must be defined for deployment.)
endif

ifndef docker_image_uri
	$(error Docker image name must be defined for deployment.)
endif
	cd ../terraform/docker $(ec2_public_ip) $(docker_image_uri) $(env_var) && make deploy-service


# only do this if you want to terminate ec2 instance
clean-ec2:
	cd ../terraform/env/${DIRECTORY} && make clean-ec2