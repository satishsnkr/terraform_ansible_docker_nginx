variable "access_key" {}
variable "secret_key" {}

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