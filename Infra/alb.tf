module "http" {
  source              = "terraform-aws-modules/security-group/aws"
  version             = "~> 4.0"
  name                = local.http_sg_name
  description         = local.http_sg_description
  vpc_id              = local.vpc_id
  ingress_cidr_blocks = local.http_ingress_cidr_blocks
  ingress_rules       = local.http_ingress_rules
  egress_rules        = local.http_egress_rules

}

module "alb" {
  source                  = "terraform-aws-modules/alb/aws"
  version                 = "~> 6.0"
  name                    = local.alb_name
  load_balancer_type      = local.load_balancer_type
  vpc_id                  = local.vpc_id
  security_groups         = [module.http.security_group_id]
  subnets                 = local.public_subnet_ids
  http_tcp_listeners      = local.http_tcp_listeners
  http_tcp_listener_rules = local.http_tcp_listener_rules
}