locals {
  region                     = var.region

  # autoScaling
  as_name                      = "${var.env}-${var.service_name}-asg"
  as_min_size                  = var.as_min_size
  as_max_size                  = var.as_max_size
  as_desired_capacity          = var.as_desired_capacity
  as_wait_for_capacity_timeout = var.as_wait_for_capacity_timeout
  as_health_check_type         = var.as_health_check_type
  as_launch_template_version   = var.as_launch_template_version
  protect_from_scale_in        = var.protect_from_scale_in
  # launch template
  launch_template_name         = "${var.env}-${var.service_name}-lt"
  launch_template_description  = var.launch_template_description
  instance_name                = "${var.env}-${var.service_name}-ec2"
  image_id                     = var.image_id
  // ami_filters_name             = "${var.env}-packer-${var.service_name}-*"
  // image_id                     = data.aws_ami.this.id
  instance_type                = var.instance_type
  key_name                     = var.key_name
  iam_instance_profile_arn     = "arn:aws:iam::${var.aws_account_id}:instance-profile/admin-full-access"
  update_default_version       = var.update_default_version
  enable_monitoring            = var.enable_monitoring
  ebs_optimized                = var.ebs_optimized


  ########################## ECS CLUSTER
  ecs_cluster_name           = "${var.env}-${var.ecs_cluster_name}"
  container_insights         = var.container_insights
  capacity_providers         = var.capacity_providers
  ecs_cluster_tags           = merge(var.ecs_cluster_tags, { Name = format("%s-ecs-cluster", var.env) })
  
  ########################## ECS TASK DEFINITION
  family                     = "${var.env}-${var.family}"
  requires_compatibilities   = var.requires_compatibilities
  execution_role_arn         = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  network_mode               = var.network_mode
  container_definitions_path = var.container_definitions_path
  cpu                        = var.cpu
  memory                     = var.memory
  image_url                  = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.image_name}:${var.image_tag}"

  ########################## ECS SERVICE
  ecs_service_name           = var.ecs_service_name
  scheduling_strategy        = var.scheduling_strategy
  force_new_deployment       = var.force_new_deployment
  desired_count              = var.desired_count
  container_name             = var.container_name
  container_port             = var.container_port
  launch_type                = var.launch_type
  capacity_provider_weight   = var.capacity_provider_weight
  capacity_provider_base     = var.capacity_provider_base
  deployment_controller      = var.deployment_controller

  ########################## ALB
  load_balancer_type         = var.load_balancer_type
  alb_name                   = "${var.env}-${var.alb_name}-${var.ecs_service_name}"
  http_sg_name               = format("%s-http-sg", "${var.env}-${var.alb_name}")
  target_group_arns          = [module.alb.target_group_arns[0]]
  target_group_name          = "tg-"
  http_tcp_listeners         = var.http_tcp_listeners
  http_tcp_listener_rules    = var.http_tcp_listener_rules
  target_groups              = [
    {
      name_prefix      = local.target_group_name
      backend_protocol = var.backend_protocol
      backend_port     = var.backend_port
      target_type      = var.target_type
    }
  ]

  # efs
  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  performance_mode                = var.performance_mode
  encrypted                       = var.encrypted
  kms_key_id                      = var.kms_key_id
  efs_security_groups             = var.efs_security_groups
  efs_backup_policy               = var.efs_backup_policy


  ########################## VPC
  vpc_id                   = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids        = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids       = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  azs                      = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id            = data.terraform_remote_state.vpc.outputs.default_security_group_id
  security_group_id        = data.terraform_remote_state.vpc.outputs.security_group_id
  ########################## SECURITY GROUP
  http_sg_description      = var.http_sg_description
  http_ingress_cidr_blocks = var.http_ingress_cidr_blocks
  http_ingress_rules       = var.http_ingress_rules
  http_egress_rules        = var.http_egress_rules
}