terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
        version = "~> 3.27"
    }
  }   
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key 
}

resource "aws_instance" "app_vm" {
  # Ubuntu Linux 20.04 AMI , SSD Volume Type
  ami                         = var.ami
  instance_type               = "t2.micro"

  tags = {
    Name      = "tfdemo-ss"
    createdBy = "terrform-demo-ss"
  }
}