resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = local.as_name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = module.asg.autoscaling_group_arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 5
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 10
    }
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = local.ecs_cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "foo" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]
	default_capacity_provider_strategy {
	capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
	weight = 1
	base = 0
  }

}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = local.family
  requires_compatibilities = local.requires_compatibilities
  execution_role_arn       = local.execution_role_arn
  network_mode             = local.network_mode
  cpu                      = local.cpu
  memory                   = local.memory
  //container_definitions    = file(local.container_definitions_path)
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "${local.container_name}",
    "image": "${local.image_url}",
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${local.container_port},
        "hostPort": ${local.container_port}
      }
    ]   
  }
]
TASK_DEFINITION
}

resource "aws_ecs_service" "ecs_service" {
  name                 = local.ecs_service_name
  cluster              = aws_ecs_cluster.ecs_cluster.id
  task_definition      = aws_ecs_task_definition.ecs_task.arn
  scheduling_strategy  = local.scheduling_strategy
  force_new_deployment = local.force_new_deployment
  desired_count        = local.desired_count
  launch_type          = local.launch_type
  network_configuration {
    subnets         = local.private_subnet_ids
    // security_groups = [module.http.security_group_id, local.default_sg_id]
    security_groups = [local.security_group_id]

  }
  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = local.container_name
    container_port   = local.container_port
  }
  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition,
    ]
  }

  deployment_controller {
    type = local.deployment_controller
  }
}