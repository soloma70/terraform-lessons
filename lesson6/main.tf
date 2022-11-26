provider "aws" {
  
}

data "aws_region" "current" {}
data "aws_availability_zones" "working_zones" {}
data "aws_caller_identity" "current" {}
data "aws_vpcs" "my_vpcs" {}

data "aws_vpc" "prod_vpc" {
    tags = {
      Name = "ProdVPC"
    }
}

resource "aws_subnet" "Prod_Subnet_1" {
    vpc_id = data.aws_vpc.prod_vpc.id
    availability_zone = data.aws_availability_zones.working_zones.names[0]
    cidr_block = "192.168.1.0/24"
    tags = {
      Name = "SubNet-1 in ${data.aws_availability_zones.working_zones.names[0]}"
      Account = "In Account: ${data.aws_caller_identity.current.account_id}"
      Region = data.aws_region.current.description
    }
}

resource "aws_subnet" "Prod_Subnet_2" {
    vpc_id = data.aws_vpc.prod_vpc.id
    availability_zone = data.aws_availability_zones.working_zones.names[1]
    cidr_block = "192.168.2.0/24"
    tags = {
      Name = "SubNet-2 in ${data.aws_availability_zones.working_zones.names[1]}"
      Account = "In Account: ${data.aws_caller_identity.current.account_id}"
      Region = data.aws_region.current.description
    }
}
