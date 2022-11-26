variable "region" {
  description = "Please enter AWS Region to deploy Server"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "List of Ports to open for Server"
  type        = list
  default     = ["80", "443", "22", "8080"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = false
}


variable "common_tags" {
  description = "Common Tags to apply on all resources"
  type        = map
  default = {
    Owner       = "Soloma70"
    Project     = "KarDon"
    Environment = "DEV"
  }
}
