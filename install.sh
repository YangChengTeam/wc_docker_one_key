#! /bin/sh
sudo yum install -y yum-utils
sudo yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io


sudo curl -L "https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cat <<EOT >> greetings.txt
{

    "registry-mirrors":["https://almtd3fa.mirror.aliyuncs.com"]      

}
EOT

sudo systemctl enable docker
sudo systemctl start docker
