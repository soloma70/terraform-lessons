provider "aws" {
    region = "ap-southeast-1"
}

#------------------------------------------------------------------

module "vpc_prod" {
    //source = "../modules/aws_network"
    source = "git@github.com:soloma70/terraform-modules.git//aws_network"
    env = "prod"
    vpc_cidr = "10.100.0.0/16"
    public_subnet_cidrs = ["10.100.1.0/24"]
    private_subnet_cidrs = ["10.100.11.0/24"]
}

module "vpc_dev" {
    //source = "../modules/aws_network"
    source = "git@github.com:soloma70/terraform-modules.git//aws_network"
    env = "dev"
    vpc_cidr = "10.10.0.0/16"
    public_subnet_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]
    private_subnet_cidrs = []
}

#------------------------------------------------------------------

output "prod_public_subnet_ids" {
    value = module.vpc_prod.public_subnet_ids
}

output "prod_private_subnet_ids" {
    value = module.vpc_prod.private_subnet_ids
}

output "dev_public_subnet_ids" {
    value = module.vpc_dev.public_subnet_ids
}

output "dev_private_subnet_ids" {
    value = module.vpc_dev.private_subnet_ids
}

