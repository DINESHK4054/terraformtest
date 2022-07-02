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
  public_key = "ssh-rsa LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBNWFtaHBZTzVZSU04Z29ldE5ZbmFkSmhDSjE1SU02SEd5R3lrcTNLS0FITHJ3ZFBXClp3cVNpdCtvZ2dPRG42TU00Zi93R0NtWk5yZkRIYmlQODlaU2RaRGl3ZGlhNzRrUFprS24wdW1FTkM3N0ZKa0gKTmJKMnZWNmV5RHhQVUtyUUh3ZnI5c0tUTXhZWlBybmJhNTIzZDZGdjNXeFZXUFQ2SGNUUDFiQmJTTlFRTzk5WgpCWjNDZ29zMlZpYTNQZ2pOczNIV0VLVmplc3VMR2M1KzBCK2t3ZXdBK3JpcXpUcUtmeGphajFXWnppb2lFeDZpCmNUWkduNlZMaElVN2xQRFljY2Y4VVREZjBGMGJZbHQ5M05WTVdHYUhlQzlSczNpMzFPUEd0NmkrSFRYdkNhRWIKZWszVld3a1VpYWV6enEwZnB1b3VjWUFvRnFaQWl1Rks5eXJrbVFJREFRQUJBb0lCQUNvTGVocHhHUmtBTGEyLwo1UWZ1S3Q0NW1iTFhZZVNCODRCeDAxdkg1bGZhc2lxVCs2WjFtd3B0azgzcGtzbEE4blRWaEVFSUxKS0Y1ZVNsCkMwV2FzUkh3Nm5LT2t4N1RPc3gvMjNXVFpxNmZBenhzSDVQSERsSHc1cVRGMWNkdzNoVXdRQlMyM25mMXpiMWMKRFQyUWJDd3NrK3czanhCd0dQSW1POTVsSVBFZCtPZy9mVVhZa0FvZkljbGFNNUlVcitkQzNBMVhHVjZtWHNqRQpLcWw0eHc1ZEVhZWFpTEp0SmcyMG00RTRkMTdBQUdLMzRWVURpMHVIZCtMUGVyRHZlSlJCaVJrMUJQdmJVN0JXCnkvM0dMVXNTSU96b3JuVFY4cHJ0TWkwbDVqVEZCMEt1TGExWmI2dWxvd2ZjSS9ST2NBN3JOTEJuTVg1RjdnYS8KcmNNK3VlRUNnWUVBOWhNRk5SdGxkOEdVR3BWQy9BdS82MUt1RlJkTjVydXl6NXIrSDZzVVpOaUQvY200WWZZMQowejhrRGZGbW5mT1BVVXhPOGFDckpkcDJ4SGRmZVFFR2NqcllLRlo2VGExOFk3dGFqbHN2dU9ZenBQYVhIWloyCitabTlWSmlzQ2hjZzcwQVYrZnNnQVJaQmVZaFFjTVgzNUpISWhqYmpqSFNoUkJCeWEwWU9nc1VDZ1lFQTd1MGsKbmNORElqTDI4STZwck5vZGZFSy9xL2xuREU1eGdZVW03U0RKM0xhcUhSOXFYWGs1aVNUWUk2elR5YnFjNGQrWgpYYXJDSzZ2ODZSRXNJUXgzTU1BTGxHd1lTaXRuNnVralBQMWxxNmg5L1ovbXZLTVVSb013RVFmbUpIOWdrdVBYCnJoTUZHTHlxUmk0MWJPNGRJamVybGxCMmxuc1NGS2pwUUZRSFo4VUNnWUFqRU1UT001QTdCNGZPWGZURXEvdjIKVWJyaTRJWkdXZnI2SUpFVC9ESVV5TkhPU1grUDNpRC9jR0QzNTYyQzFxRldxWFFhZEpYTytCbXlsM3d3WnhmLwpFU21hWGZCaHYxWVpkQ3BNWE93cEFnemI5aFBFc0p0VnFEWFZwMGZrekRUeVF3U2VzYzEydWpBc1hHTnlIcFBiCnEzYVN3YUdkYzBWRHlNQTFUeTlrTFFLQmdRQ0swQVNDRkR3ZzFuTlo5OGprd0NSNVdWNTZ6Ly9xeW5odnc2aUcKQkpMRFJPMDQxbE81MHdCMmlZMTV6S09QaEhnNVV1dUwyL1hMNGJTaXhITmJFQjcvbDlRaWUxcnhYSjZYZ0xRVQpielJ1c3duZ0hOSzFyaG5OamRLVFVuK0huT25DN2RVVk1iKzRTNFN5R1k2NHB1OE9Qa0hXcHhEL0JLblFqd0pWCmVYeUQ4UUtCZ1FEcGhJQTJ4dEYyRnZkcVdjYTNJMDljUDBsTVFnOFE1bVJUYlk3K2lISXd2RmIxOEt5L2x3eVEKbkJ5ZGljbnNUTmlrVTJCTzY0TEsxRi9YaU9vMUlaZ3lSWm9nZElUYXpnSk1GNkd6c0VCWkVCWTNDWW55T0c1WQpjYXhoUUNQRzRyb0VLL3RweXFUTG85dzFmL0lzZVBYcUFOUGJsTlh3NmNXTjlEanNqT2ZMamc9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQ"
}
resource "aws_launch_configuration" "test_devops" {
  name          = "test_devops"
  image_id      = "ami-02b6d9703a69265e9"
  instance_type = "t2.micro"
}
