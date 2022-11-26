# Auto Fill Parametrs for DEV

region = "ca-central-1"

instance_type = "t2.micro"

allow_ports = ["80", "443", "22"]

common_tags = {
    Owner       = "Soloma70"
    Project     = "KarDon"
    Environment = "DEV"
}