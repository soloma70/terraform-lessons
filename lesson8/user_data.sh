#!/bin/bash
yum -y update
yum -y install httpd


myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h1><font color="gold">Build by Terraform <font color="red"> v.1.3.5</font></h1><br><p>
<h2><font color="gold">Design by Soloma70</h2><br><br>
<font color="green">Server PrivateIP: <font color="aqua">$myip<br><br>
<font color="magenta">
<b>Version 2.0</b>
</body>
</html>
EOF

sudo systemctl enable httpd.service
sudo systemctl start httpd.service