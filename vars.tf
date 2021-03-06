variable "aws_access_key" {
    description = "Provide your AWS ACCESS KEY ID:"
}
variable "aws_secret_key" {
    description = "Provide your AWS SECRET ACCESS KEY:"
}

variable "region" {
    type = string
    description = "aws region where the VM will be provisioned"
    default = "ap-southeast-2"
}

variable "ami" {
    type = string
    description = "aws ami used to provision the VM  -- using Ubuntu 20.04 ami"
    default = "ami-0567f647e75c7bc05"
}

variable "vpc_name" {
    description = "Name of VPC"
    type = string
    default = "tfdemo-vpc"
}

variable "vpc_cidr" {
    description = "CIDR rage for VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
    description = "CIDR rage for public subnets"
    type = list(string)
    default = ["10.0.101.0/24"]
}

variable "tfdemo_sg" {
    description = "Security group to allow incoming connections"
    type = string
    default = "tfdemo-security-group"
}

locals {
    my_ip = jsondecode(data.http.my_public_ip.body)
}

data "http" "my_public_ip" {
    url = "https://ifconfig.co/json"
    request_headers = {
        Accept = "application/json"
    }
}

variable "tfdemo_ssh_public_key" {
    type = string
    description = "Provide your ssh public key from ~/.ssh/id_rsa.pub"
}

