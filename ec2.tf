# Configure the AWS Provider
provider "aws" {
  access_key = "AKIAUSA7BRMZGP5XJ7GK"
  secret_key = "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"
  region  = "ap-southeast-1"
}
resource "aws_vpc" "vpc_devops" {
  cidr_block       = "190.160.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_devops"
    Location ="Singapore"
  }
}
 resource "aws_subnet" "sub_public_devops" {
  vpc_id     = "${aws_vpc.vpc_devops.id}"
  cidr_block = "190.160.1.0/24"

 tags = {
    Name = "sub_public_devops"
    
  }
}
resource "aws_security_group" "sg_devops" {
  name        = "sg_devops"
  description = "sg_devops_inbound traffic"
  vpc_id      = "${aws_vpc.vpc_devops.id}"

  ingress {
    description = "sg_devops from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "sg_devops from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_devops"
  }
}

resource "aws_instance" "test_devops" {

ami           = "ami-02b6d9703a69265e9"
  instance_type = "t2.micro"

  tags = {
    Name = "test_devops"
  }
}

resource "aws_key_pair" "test_devops" {
  key_name   = "test_devops-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
resource "aws_launch_configuration" "test_devops" {
  name          = "test_devops"
  image_id      = "ami-02b6d9703a69265e9"
  instance_type = "t2.micro"
}
