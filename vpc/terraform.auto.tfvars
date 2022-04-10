env    = "dev"
name   = "ecs-vpc"
owner  = "dcc"
region = "ap-northeast-2"

vpc_cidr                           = "10.0.0.0/16"
azs                                = ["ap-northeast-2a", "ap-northeast-2c"]
public_subnets                     = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets                    = ["10.0.2.0/24", "10.0.3.0/24"]
database_subnets                   = ["10.0.4.0/25", "10.0.4.128/25"]
create_database_nat_gateway_route  = false
create_database_subnet_route_table = true
enable_ipv6                        = false
enable_nat_gateway                 = true
single_nat_gateway                 = true

tags                               = {}
vpc_tags                           = {}
private_subnet_tags                = {}
public_subnet_tags                 = {}
