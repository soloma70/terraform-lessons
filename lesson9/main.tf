#----------------------------------------------------------
# Terraform
#
# Variables
#
# Made by Soloma70
#----------------------------------------------------------

provider "aws" {
    region = var.region
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

data "aws_ami" "latest_amazon_linux" {
    owners      = ["amazon"]
    most_recent = true
    
    filter {
        name   = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }

}

data "aws_region" "current" {}
data "aws_availability_zones" "avaliable" {}

resource "aws_eip" "my_static_ip" {
    vpc      = true # Need to add in new AWS Provider version
    instance = aws_instance.my_server.id

    tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server IP" })

}

resource "aws_instance" "my_server" {
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = var.instance_type
    vpc_security_group_ids = [aws_security_group.my_server.id]
    monitoring             = var.enable_detailed_monitoring

    tags = merge(var.common_tags, 
                { Name = "${var.common_tags["Environment"]} Server Terraform"}, 
                { Region = data.aws_region.current.description},
                { AZ_List = join(",", data.aws_availability_zones.avaliable.names)}
                )

}

resource "aws_security_group" "my_server" {
    name   = "My Security Group"
    vpc_id = aws_default_vpc.default.id

    dynamic "ingress" {
        for_each = var.allow_ports
        content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server SG" })

}