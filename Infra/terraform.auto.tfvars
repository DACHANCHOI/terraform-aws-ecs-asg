service_name               = "dcc-was"
owner                      = "dcc"
env                        = "dev"
region                     = "ap-northeast-2"
aws_account_id             = ""

#autoScaling
as_min_size                  = 2
as_max_size                  = 2
as_desired_capacity          = 2
as_wait_for_capacity_timeout = 0
as_health_check_type         = "EC2"
as_launch_template_version   = "$Latest"
protect_from_scale_in        = true
# launch template
launch_template_description  = "Launch template example"
# ECS Optimized AMI
image_id                     = "ami-04c0ac9468f496b8e"
instance_type                = "t2.micro"
key_name                     = "Mac-DC"
iam_instance_profile_arn     = ""
update_default_version       = true
enable_monitoring            = false
ebs_optimized                = false

########################## ECS Cluster
ecs_cluster_name           = "ecs-cluster"
container_insights         = true
capacity_providers         = ["FARGATE", "FARGATE_SPOT"]
ecs_cluster_tags           = {}

########################## ECS Task Definition
family                     = "ecs-task"
requires_compatibilities   = ["EC2"]
image_name                 = "dev-pipeline-demo"
image_tag                  = "latest"
execution_role_arn         = ""
network_mode               = "awsvpc"
container_definitions_path = "task-definitions/service.json"
cpu                        = 256
memory                     = 512

########################## ECS Service
ecs_service_name           = "ecs-demo-service"
scheduling_strategy        = "REPLICA"
force_new_deployment       = true
desired_count              = 1
container_name             = "demo"
container_port             = 80
launch_type                = "EC2"
capacity_provider_weight   = 100
capacity_provider_base     = 1
// deployment_controller      = "CODE_DEPLOY"
deployment_controller   = "ECS"

########################## ALB
load_balancer_type         = "application"
target_type                = "ip"
backend_protocol           = "HTTP"
backend_port               = "80"
alb_name                   = "alb"
http_tcp_listeners = [
  {
    port        = 80
    protocol    = "HTTP"
    action_type = "fixed-response"
    fixed_response = {
      content_type = "text/plain"
      message_body = "Not found"
      status_code  = "403"
    }
  }
]
http_tcp_listener_rules = [
  {
    http_listener_index = 0
    actions = [{
      type               = "forward"
      target_group_index = 0
    }]
    conditions = [{
      path_patterns = ["/*"]
    }]
  }
]

# efs
throughput_mode                 = "bursting"
// throughput_mode                 = "provisioned"
provisioned_throughput_in_mibps = 0
performance_mode                = "generalPurpose"
// performance_mode                = "maxIO" 
encrypted                       = true
kms_key_id                      = ""
efs_security_groups             = ["sg-08ff15cf0a0d68deb"]
efs_backup_policy               = "ENABLED"

########################## Security Group
http_sg_description        = "HTTP Security group for ALB"
http_ingress_cidr_blocks   = ["0.0.0.0/0"]
http_ingress_rules         = ["http-80-tcp"]
http_egress_rules          = ["all-all"]