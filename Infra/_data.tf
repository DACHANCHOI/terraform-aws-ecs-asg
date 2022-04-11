data "aws_caller_identity" "current" {}

data "template_file" "userdata" {
  template = file("templates/userdata.sh")
  vars = {
    ACCOUNT_ID        = data.aws_caller_identity.current.account_id
    REGION            = var.region
    efs_dns_name      = aws_efs_file_system.file_system.dns_name
    ecs_cluster_name  = local.ecs_cluster_name
  }
}