output "data_aws_region_name" {
    value = data.aws_region.current.name
}

output "data_aws_region_description" {
    value = data.aws_region.current.description
}

output "data_aws_availability_zones" {
    value = data.aws_availability_zones.working_zones.names  
}

output "data_aws_caller_identity" {
    value = data.aws_caller_identity.current.account_id
}

output "data_aws_vpcs" {
    value = data.aws_vpcs.my_vpcs.ids
}

output "data_aws_prod_vpc_id" {
    value = data.aws_vpc.prod_vpc.id
}

output "data_aws_prod_vpc_cidr_block" {
    value = data.aws_vpc.prod_vpc.cidr_block
}