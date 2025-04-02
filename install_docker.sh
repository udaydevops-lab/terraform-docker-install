#!/bin/bash

#check whether root user or not
R="\e[31m"
N="\e[0m"



yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker

# sudo groupadd docker
# sudo useradd -m -s /bin/bash docker
# sudo usermod -aG docker docker

sudo useradd -m -s /bin/bash -g docker docker
sudo usermod -aG docker docker
echo -e "$R Logout and Login again $N"


sudo growpart /dev/nvme0n1 4
# Extend logical volumes
sudo lvextend -l +50%FREE /dev/RootVG/rootVol
sudo lvextend -l +50%FREE /dev/RootVG/varVol

# Resize the filesystems to use the extended space
sudo xfs_growfs /
sudo xfs_growfs /var
