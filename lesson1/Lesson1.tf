provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "Soloma_Ubuntu" {
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
    tags = {
        Name = "Soloma Ubuntu Server"
        Owner = "Soloma70"
        Project = "Terraform Test"
    }
}

resource "aws_instance" "Soloma_Amazon" {
    ami = "ami-076309742d466ad69"
    instance_type = "t2.micro"
    tags = {
        Name = "Soloma Amazon Server"
        Owner = "Soloma70"
        Project = "Terraform Test"
    }
}