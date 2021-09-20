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

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs            = ["${var.region}a"]
  public_subnets  = var.vpc_public_subnets

  tags = {
    createdBy = "<%=username%>"
  }
}