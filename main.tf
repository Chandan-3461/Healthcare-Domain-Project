provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "test_cluster" {
    ami           = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    count         = 1
    tags = {
        Name = "Production_server"
    }
}

