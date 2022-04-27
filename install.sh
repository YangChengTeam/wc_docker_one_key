#! /bin/sh


DISTRO='CentOS'
if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
    elif grep -Eqi "Red Hat Enterprise Linux" /etc/issue || grep -Eq "Red Hat Enterprise Linux" /etc/*-release; then
        DISTRO='RHEL'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
    else
        DISTRO='unknow'
fi

if [[ ${DISTRO} == "CentOS" ]];then
    echo "docker installing on CentOS"
    sudo yum install -y yum-utils
    sudo yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io

    sudo systemctl enable docker
    sudo systemctl start docker
    cat <<EOT >  /etc/docker/daemon.json 
{

        "registry-mirrors":["https://almtd3fa.mirror.aliyuncs.com"]      

}
EOT
    sudo systemctl restart docker
fi

if [[ ${DISTRO} == "Debian" ||  ${DISTRO} == "Ubuntu" ]];then
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

if [[ ${DISTRO} == "Fedora" ]];then
   sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

if [[ ${DISTRO} == "RHEL" ]];then
   yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

if [[ ! -e /usr/local/bin/docker-compose ]];then
        sudo curl -L "https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
fi

if [[ -e /usr/local/bin/docker-compose ]];then
    sudo chmod +x /usr/local/bin/docker-compose
else 
    echo "download docker-compose fail exec sh install.sh again."
    exit
fi

docker-compose build
docker-compose up -d