#--------------------------------------------
# My WebSerwer on Terraform
#
# Node by Soloma70
#--------------------------------------------

provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "soloma_webserver" {
    ami = "ami-076309742d466ad69"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.soloma_webserver.id]
    user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Building by Terraform" > /var/www/html/index.html
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
EOF

    tags = {
      Name = "WebServer-S70-Terraform"
    }
}

resource "aws_security_group" "soloma_webserver" {
    name = "WebSerwer SG Soloma"
    description = "WebSerwer SG Soloma"

    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "WS_SG_Soloma"
    }
}
