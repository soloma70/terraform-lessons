#--------------------------------------------
# My WebSerwer on Terraform
#
# Node by Soloma70
#--------------------------------------------

provider "aws" {
    region = "eu-central-1"
}

resource "aws_eip" "soloma_sip" {
    instance = aws_instance.soloma_ws.id  
}

resource "aws_instance" "soloma_ws" {
    ami = "ami-076309742d466ad69"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.soloma_ws.id]
    user_data = templatefile("user_data.sh.tpl", {
        f_name = "Mykhailo",
        s_name = "Solomashenko",
        a_name = "Soloma70",
        names = ["Vasya", "Petya", "Masha"]
    })

    tags = {
      Name = "WebServer-Terraform"
      Owner = "Soloma70"
    }

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_security_group" "soloma_ws" {
    name = "WS SG Dyn Soloma"
    description = "WebSerwer with dynamic SG Soloma"

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
        Name = "SG-WebServer-Dynamic"
        Owner = "Soloma70"
    }

}
