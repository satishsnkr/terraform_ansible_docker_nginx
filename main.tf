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
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.vm_sg.id]

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
    Name      = "tfdemo-ss"
    createdBy = "terrform-demo-ss"
  }
}

resource "aws_security_group" "vm_sg" {
  name          = var.tfdemo_sg
  vpc_id        = module.vpc.vpc_id

  tags = {
    Name      = "tfdemo-ss"
    createdBy = "terrform-demo-ss"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.my_ip.ip}/32"]
  }
}