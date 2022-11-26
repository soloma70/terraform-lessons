provider "aws" {
    region = "ap-southeast-2"
}

data "aws_ami" "latest_ubuntu" {
    owners = ["amazon"]
    most_recent = true
    filter {
        name = "name"
        values = ["*ubuntu-*-22.04-amd64-server-*"]
    }
}

data "aws_ami" "latest_amazon_linux" {
    owners = ["amazon"]
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }
}

data "aws_ami" "latest_windows_server" {
    owners = ["amazon"]
    most_recent = true
    filter {
        name = "name"
        values = ["Windows_Server-2022-English-Full-Base-*"]
    }
}

