# [12:23 PM] Ibrahim Ozbekler
# Please create 2 resources that you want with variables and use count for one of them, and use for_each for other one. Send it to me with github link until 13.00 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.56.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "b" {
  bucket = "${var.s3-bucket-name}-${count.index}"
  count  = var.number-of-bucket
}

# resource "aws_instance" "ec2" {
#     ami = var.ami-index
#     instance_type = var.ec2-instance-type
# }

resource "aws_instance" "ec2" {
  for_each = toset(var.ami-index)
  ami = each.value
  instance_type = var.ec2-instance-type

}


variable "s3-bucket-name" {
  default = "s3-name-variable-000"
}

variable "number-of-bucket" {
  default = 4
}

variable "ami-index" {
    default = ["ami-006dcf34c09e50022", "ami-05b5badc2f7ddd88d"]
}

variable "ec2-instance-type" {
    default = "t2.micro"
}
