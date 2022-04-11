#!/bin/bash

yum update
yum install -y git java-1.8.0-openjdk

echo "ECS_CLUSTER=${ecs_cluster_name}" >> /etc/ecs/ecs.config
# sudo amazon-linux-extras disable docker
# sudo amazon-linux-extras install -y ecs; sudo systemctl enable --now ecs

# Mount EFS
yum install -y amazon-efs-utils
mkdir /datat
efs_dns=${efs_dns_name}
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dns_name}:/ /data
echo $efs_dns:/ /data efs defaults,_netdev 0 0 >> /etc/fstab

