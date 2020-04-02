variable "region" {
    default = "us-west-1"
}

variable "profile" {
    default = "default"
}
variable "ami" {
    default = "ami-03ba3948f6c37a4b0"
}

variable "key_name" {
    default = "ss-key"
}

variable "instance_type" {
    default = "t2.micro"
}

#services
variable "prov_hotels_search_service" {
    default = false
}