#--------------------------------------------
# My Dynamic Security Group on Terraform
#
# Node by Soloma70
#--------------------------------------------

provider "aws" {
    region = "eu-central-1"
}

resource "aws_security_group" "soloma_dynamic_sg" {
    name = "Dynamic SG Soloma"
    description = "Dynamic SG Soloma"

    dynamic "ingress" {
        for_each = ["80", "443", "8080", "22"]
        content {
            from_port        = ingress.value
            to_port          = ingress.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
        }
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "Dynamic_SG_Soloma"
    }
}
