provider "aws" {
    region = "us-west-2"
}

variable "vpcname" {
    type = string 
    default = "myvpc" 
}

variable "sshport" {
    type = number 
    default = 22 

}

variable "enabled" {
    default = true 
}

variable "mylist" {
    type = list(string)
    default = ["value1", "value2"]
}

variable "mymap"{
    type = map 
    default = {
        Key1 = "Value1"
        Key2 =  "Vavlue2"
    }
}

variable "inputname" { 
    type      = string 
    descripttion = "Set the name of the VPC"
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
}

tags = {
    name = 
}



