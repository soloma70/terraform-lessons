#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<h2>WebServer with IP: $myip</h2><br>Building by Terraform <font color="red"> v.1.3.5</font></h2><br>
Owner ${f_name} ${s_name}, aka ${a_name}<br>

%{ for name in names ~}
Hello to ${name} from ${f_name}<br>
%{ endfor ~}

</html>
EOF

sudo systemctl enable httpd.service
sudo systemctl start httpd.service