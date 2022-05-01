locals {
  region = var.region

  name                               = "${var.env}-${var.name}"
  azs                                = var.azs

  # cidr
  cidr                               = var.vpc_cidr
  private_subnets                    = var.private_subnets
  public_subnets                     = var.public_subnets
  database_subnets                   = var.database_subnets
  enable_ipv6                        = var.enable_ipv6
  
  enable_nat_gateway                 = var.enable_nat_gateway
  single_nat_gateway                 = var.single_nat_gateway
  create_database_subnet_route_table = var.create_database_subnet_route_table
  create_database_nat_gateway_route  = var.create_database_nat_gateway_route
  tags                               = merge(var.tags, { Owner = var.owner, Environment = var.env })
  vpc_tags                           = merge(var.vpc_tags, { Name = local.name })
  public_subnet_tags                 = merge(var.public_subnet_tags, { Name = format("%s-public-sb", var.name) })
  private_subnet_tags                = merge(var.private_subnet_tags, { Name = format("%s-private-sb", var.name) })
  database_subnet_group_tags         = { Name = "${var.env}-Private-DB"}
  
}