variable "access_key" {}
variable "secret_key" {}

variable "region" {
    type = string
    description = "aws region where the VM will be provisioned"
    default = "ap-southeast-2"
}

variable "ami" {
    type = string
    description = "aws ami used to provision the VM"
    default = "ami-0567f647e75c7bc05"
}