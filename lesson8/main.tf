#----------------------------------------------------------
# Provision Highly Availabe Web in any Region Default VPC

# Create:
#    - Security Group for Web Server
#    - Launch Configuration with Auto AMI Lookup
#    - Auto Scaling Group using 2 Availability Zones
#    - Classic Load Balancer in 2 Availability Zones
#
# Made by Soloma70
#-----------------------------------------------------------

provider "aws" {
    region = "ca-central-1"
}

data "aws_availability_zones" "availabe" {}

data "aws_ami" "latest_amazon_linux" {
    owners = ["amazon"]
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }
}

#-----------------------------------------------------------

resource "aws_security_group" "web_dsg" {
    name = "Web_DSG_Soloma70"
    description = "Web DSG Soloma70"

    dynamic "ingress" {
        for_each = ["80", "443"]
        content {
            from_port        = ingress.value
            to_port          = ingress.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Dynamic_SG"
        Owner = "Soloma70"
    }
}

#-----------------------------------------------------------

resource "aws_launch_configuration" "web" {
//    name          = "WebSerwer-HA-LC"
    name_prefix = "WebSerwer-HA-LC-"
    image_id      = data.aws_ami.latest_amazon_linux.id
    instance_type = "t2.micro"
    security_groups = [aws_security_group.web_dsg.id]
    user_data = file("user_data.sh")

    lifecycle {
        create_before_destroy = true
    }
}

#-----------------------------------------------------------

resource "aws_autoscaling_group" "web" {
    name = "ASG-${aws_launch_configuration.web.name}"
    launch_configuration = aws_launch_configuration.web.name
    min_size = 2
    max_size = 2
    min_elb_capacity = 2
    vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
    health_check_type = "ELB"
    load_balancers = [aws_elb.web.name]
    
    dynamic "tag" {
        for_each = {
            Name = "WebServer-ASG"
            Owner = "Soloma70"
            TAGKEY = "TAGVALUE"
        }

        content {
            key = tag.key
            value = tag.value
            propagate_at_launch = true
        }
    }

    lifecycle {
        create_before_destroy = true
    }
}

#-----------------------------------------------------------

resource "aws_elb" "web" {
    name = "WebServer-HA-ELB"
    availability_zones = [data.aws_availability_zones.availabe.names[0], data.aws_availability_zones.availabe.names[1]]
    security_groups = [aws_security_group.web_dsg.id]
    listener {
        lb_port           = 80
        lb_protocol       = "http"
        instance_port     = 80
        instance_protocol = "http"
    }
    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:80/"
        interval            = 10
    }
    tags = {
      Name = "WebServer-HA-ELB"
    }
}

#-----------------------------------------------------------

resource "aws_default_subnet" "default_az1" {
    availability_zone = data.aws_availability_zones.availabe.names[0]

    tags = {
        Name = "Default subnet 1"
  }
}

resource "aws_default_subnet" "default_az2" {
    availability_zone = data.aws_availability_zones.availabe.names[1]

    tags = {
        Name = "Default subnet 2"
  }
}

#-----------------------------------------------------------

output "web_loadbalancer_url" {
    value = aws_elb.web.dns_name
}
