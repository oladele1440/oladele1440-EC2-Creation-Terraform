# Terraform---EC2---Configuration
Creating an AWS EC2, VPC, IP Address, Subnets and Security groups

variable "awsprops" {
    type = "map"
    default = {
    region = "us-west-1"
    vpc = "vpc-5345762d"
    ami = "ami-0c1bea58988a989155"
    itype = "t2.micro"
    subnet = "subnet-81896c8e"
    publicip = true
    keyname = "myseckey"
    secgroupname = "My-Application-Sec-Group"
  }
}

provider "aws" {
  region = lookup(var.awsprops, "region")
}

resource "aws_security_group" "My-Application-Sec-Group" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["10.0.0.0/16"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "My Application" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keytagname")


  vpc_security_group_ids = [
    aws_security_group.My-Application-Sec-Group.id
  ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="SERVER01"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.My-Application-Sec-Group ]
}


output "ec2instance" {
  value = aws_instance.project-iac.public_ip

