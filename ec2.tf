terraform {
    required_providers {
        aws={
            source="hashicorp/aws"
        }
    }
}
provider "aws"{
  profile = "default"
  region  = "ap-southeast-1"
  }

resource "aws_instance" "devbox" {
    ami ="ami-02f26adf094f51167"
    instance_type="t2.micro"
  
}
