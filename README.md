# terraform-aws-ecs-asg

### Introduction

terraform 코드를 활용한 AWS ECS 프로비저닝
<img width="874" alt="image" src="https://user-images.githubusercontent.com/77256060/166134806-86db86d5-b9f9-438e-8ee3-cbfd94dfb866.png">


### Terraform Workspace List

1. VPC
2. Infra(ECS Cluster, ECS Task, ECS Service, ALB, ASG, EFS)

### Work Flow

1. VPC생성 (public, private, private-db 서브넷 각각 두개의 AZ로 생성)
2. EFS 생성
3. ASG, Launch Template(User date : efs mount, ecs agent install), ALB 생성
4. ECS Cluster(capacity_providers : AutoscalingGorup, ECS Task, ECS Service 생성)

### 사용 방법

1. git clone [https://github.com/DACHANCHOI/terraform-aws-ecs-asg.git](https://github.com/DACHANCHOI/terraform-aws-ecs-asg.git)
2. 환경변수 설정 ([aws_account_id](https://github.com/DACHANCHOI/terraform-aws-ecs-asg/blob/main/Infra/terraform.auto.tfvars))
3. terraform Backend 수정 ([vpc](https://github.com/DACHANCHOI/terraform-aws-ecs-asg/blob/main/vpc/_backend.tf), [infra](https://github.com/DACHANCHOI/terraform-aws-ecs-asg/blob/main/Infra/_backend.tf))
4. terraform init && apply 
