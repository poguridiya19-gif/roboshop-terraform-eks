#!/bin/bash
# growing the /home volume for terraform purpose
growpart /dev/nvme0n1 4
pvresize /dev/nvme0n1p4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

# install terraform 
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

# sudo lvreduce -r -L 6G /dev/mapper/RootVG-rootVol


# creating databases
# cd /home/ec2-user
# git clone  https://github.com/poguridiya19-gif/roboshop-dev-infra.git
# chown ec2-user:ec2-user -R roboshop-dev-infra
# cd roboshop-dev-infra/40-databases
# terraform init
# terraform apply -auto-approve


curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.34.2/2025-11-13/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh