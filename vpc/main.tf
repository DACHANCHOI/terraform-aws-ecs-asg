module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name                               = local.name
  cidr                               = local.cidr
  private_subnets                    = local.private_subnets
  public_subnets                     = local.public_subnets
  database_subnets                   = local.database_subnets
  azs                                = local.azs

  create_database_subnet_route_table = local.create_database_subnet_route_table
  enable_ipv6                        = local.enable_ipv6
  enable_nat_gateway                 = local.enable_nat_gateway
  single_nat_gateway                 = local.single_nat_gateway

  tags                               = local.tags
  public_subnet_tags                 = local.public_subnet_tags
  private_subnet_tags                = local.private_subnet_tags
  database_subnet_group_tags         = local.database_subnet_group_tags
  vpc_tags                           = local.vpc_tags
}

module "service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "sample-sg"
  description = "Security group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["all-tcp"]
  egress_rules             = ["all-all"]

}