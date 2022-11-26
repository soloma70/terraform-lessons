output "webserver_instance_id" {
    value = aws_instance.soloma_ws.id
}

output "webserver_instance_ami" {
    value = aws_instance.soloma_ws.ami
}

output "webserver_instance_arn" {
    value = aws_instance.soloma_ws.arn
}

output "webserver_public_ip" {
    value = aws_eip.soloma_sip.public_ip
}

output "webserver_security_group_id" {
    value = aws_security_group.soloma_ws.id
}