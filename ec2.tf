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

resource "aws_instance" "kp_devops" {

ami           = "ami-02b6d9703a69265e9"
  instance_type = "t2.micro"

  tags = {
    Name = "kp_devops"
  }
}

resource "aws_key_pair" "kp_devops" {
  key_name   = "kp_devops-key"
  public_key = "ssh-rsa
Encryption: none
Comment: imported-openssh-key
Public-Lines: 6
AAAAB3NzaC1yc2EAAAADAQABAAABAQDlqaGlg7lggzyCh601idp0mEInXkgzocbI
bKSrcooAcuvB09ZnCpKK36iCA4Ofowzh//AYKZk2t8MduI/z1lJ1kOLB2JrviQ9m
QqfS6YQ0LvsUmQc1sna9Xp7IPE9QqtAfB+v2wpMzFhk+udtrnbd3oW/dbFVY9Pod
xM/VsFtI1BA731kFncKCizZWJrc+CM2zcdYQpWN6y4sZzn7QH6TB7AD6uKrNOop/
GNqPVZnOKiITHqJxNkafpUuEhTuU8Nhxx/xRMN/QXRtiW33c1UxYZod4L1GzeLfU
48a3qL4dNe8JoRt6TdVbCRSJp7POrR+m6i5xgCgWpkCK4Ur3KuSZ
Private-Lines: 14
AAABACoLehpxGRkALa2/5QfuKt45mbLXYeSB84Bx01vH5lfasiqT+6Z1mwptk83p
kslA8nTVhEEILJKF5eSlC0WasRHw6nKOkx7TOsx/23WTZq6fAzxsH5PHDlHw5qTF
1cdw3hUwQBS23nf1zb1cDT2QbCwsk+w3jxBwGPImO95lIPEd+Og/fUXYkAofIcla
M5IUr+dC3A1XGV6mXsjEKql4xw5dEaeaiLJtJg20m4E4d17AAGK34VUDi0uHd+LP
erDveJRBiRk1BPvbU7BWy/3GLUsSIOzornTV8prtMi0l5jTFB0KuLa1Zb6ulowfc
I/ROcA7rNLBnMX5F7ga/rcM+ueEAAACBAPYTBTUbZXfBlBqVQvwLv+tSrhUXTea7
ss+a/h+rFGTYg/3JuGH2NdM/JA3xZp3zj1FMTvGgqyXadsR3X3kBBnI62ChWek2t
fGO7Wo5bL7jmM6T2lx2WdvmZvVSYrAoXIO9AFfn7IAEWQXmIUHDF9+SRyIY244x0
oUQQcmtGDoLFAAAAgQDu7SSdw0MiMvbwjqms2h18Qr+r+WcMTnGBhSbtIMnctqod
H2pdeTmJJNgjrNPJupzh35ldqsIrq/zpESwhDHcwwAuUbBhKK2fq6SM8/WWrqH39
n+a8oxRGgzARB+Ykf2CS49euEwUYvKpGLjVs7h0iN6uWUHaWexIUqOlAVAdnxQAA
AIEA6YSANsbRdhb3alnGtyNPXD9JTEIPEOZkU22O/ohyMLxW9fCsv5cMkJwcnYnJ
7EzYpFNgTuuCytRf14jqNSGYMkWaIHSE2s4CTBehs7BAWRAWNwmJ8jhuWHGsYUAj
xuK6BCv7acqky6PcNX/yLHj16gDT25TV8OnFjfQ47Izny44=
Private-MAC: fbf7f5607bcc84c7932b1035598855ed9f3dc6e5"
}
resource "aws_launch_configuration" "kp_devops" {
  name          = "kp_devops"
  image_id      = "ami-02b6d9703a69265e9"
  instance_type = "t2.micro"
}
resource "aws_elb" "bar" {
  name               = "terraform-elb"
  availability_zones = ["ap-southeast-1"]

  access_logs {
    bucket        = "foo"
    bucket_prefix = "bar"
    interval      = 60
  }
 listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
listener {
    instance_port      = 8080
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/terraform"
}

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }
 instances                   = [aws_instance.foo.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "terraform-elb"
  }
}
