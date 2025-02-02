resource "aws_instance" "test_cluster" {
    ami           = "ami-00bb6a80f01f03502"
    instance_type = "t3.medium"
    count         = 1
    tags = {
        Name = "Production_server"
    }
}

