# Configure the AWS Provider
provider "aws" {
  access_key = "XXXXXXXXXX"
  secret_key = "XXXXXXXXXXX"
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
resource "aws_launch_configuration" "test_devops" {
  name          = "test_devops"
  image_id      = "ami-02b6d9703a69265e9"
  instance_type = "t2.micro"
}
