sudo apt update
sudo apt upgrade -y

# Docker
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce -y
sudo systemctl status docker
sudo docker --version

# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K[0-9.]+')" /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# HTOP
sudo apt install htop -y

# PM2
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install pm2@latest -g
pm2 --version

# Nginx
sudo apt install nginx -y

# Python
sudo apt install python3 python3-pip -y
python3 --version
pip3 --version

# Vim
sudo apt install vim -y

# MySQL
sudo apt install mysql-server -y
sudo mysql_secure_installation
sudo systemctl status mysql
