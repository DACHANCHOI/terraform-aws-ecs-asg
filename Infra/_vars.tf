variable "service_name" {}
variable "env" {}
variable "alb_name" {}
variable "owner" {}
variable "region" {}
variable "aws_account_id" {}

# autoScaling
// variable "as_name" {}
variable "as_min_size" {}
variable "as_max_size" {}
variable "as_desired_capacity" {}
variable "as_wait_for_capacity_timeout" {}
variable "as_health_check_type" {}
variable "as_launch_template_version" {}
variable "protect_from_scale_in" {}
# launch template
variable "launch_template_description" {}
variable "image_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "iam_instance_profile_arn" {}
variable "update_default_version" {}
variable "enable_monitoring" {}
variable "ebs_optimized" {}

########################## ECS Cluster 
variable "ecs_cluster_name" {}
variable "container_insights" {}
variable "capacity_providers" {}
variable "ecs_cluster_tags" {}

########################## ECS Task Definition
variable "family" {}
variable "requires_compatibilities" {}
variable "execution_role_arn" {}
variable "network_mode" {}
variable "container_definitions_path" {}
variable "cpu" {}
variable "memory" {}
variable "image_name" {}
variable "image_tag" {}

########################## ECS Service
variable "ecs_service_name" {}
variable "scheduling_strategy" {}
variable "force_new_deployment" {}
variable "desired_count" {}
variable "container_name" {}
variable "container_port" {}
variable "launch_type" {}
variable "capacity_provider_weight" {}
variable "capacity_provider_base" {}
variable "deployment_controller" {}

########################## ALB
variable "load_balancer_type" {}
variable "http_tcp_listeners" {}
variable "http_tcp_listener_rules" {}
variable "target_type" {}
variable "backend_protocol" {}
variable "backend_port" {}

########################## Security Group
variable "http_sg_description" {}
variable "http_ingress_cidr_blocks" {}
variable "http_ingress_rules" {}
variable "http_egress_rules" {}

# efs
variable "throughput_mode" {}
variable "provisioned_throughput_in_mibps" {}
variable "performance_mode" {}
variable "encrypted" {}
variable "kms_key_id" {}
variable "efs_security_groups" {}
variable "efs_backup_policy" {}
