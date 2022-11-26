#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Building by Terraform, using external file" > /var/www/html/index.html
sudo systemctl enable httpd.service
sudo systemctl start httpd.service