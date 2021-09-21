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
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key 
}

resource "aws_instance" "app_vm" {
  # Ubuntu Linux 20.04 AMI , SSD Volume Type
  ami                         = var.ami
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.vm_sg.id]
  key_name                    = aws_key_pair.app_ssh.key_name

  tags = {
    Name      = "tfdemo-ss"
    createdBy = "terrform-demo-ss"
  }
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.app_vm.id
  vpc      = true
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
    # nginx application access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

resource "random_string" "random" {
  length           = 4
  special          = true
  override_special = "/@£$"
}

resource "aws_key_pair" "app_ssh" {
  key_name   = "application-ssh-${random_string.random.result}"
  public_key = var.tfdemo_ssh_public_key

  tags = {
    Name      = "tfdemo-ss"
    createdBy = "terrform-demo-ss"
  }
}
