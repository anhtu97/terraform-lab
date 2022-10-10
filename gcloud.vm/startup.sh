#!/bin/bash

# Install Caddy
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

# Install environment
apt update
apt upgrade -y
apt install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools git net-tools redis-server
pip3 install pipenv

# setting redis
sed -i "s/supervised no/supervised systemd/g" /etc/redis/redis.conf
systemctl restart redis.service

# install CTFd
mkdir -p /var/www
cd /var/www
git clone https://github.com/CTFd/CTFd.git

# Create a pipenv to run CTFd in
pipenv install --python 3.6
cd /var/www/CTFd
pip3 install -r requirements.txt

# Create CTFd service
echo """
[Unit]
Description=CTFd

[Service]
User=root
WorkingDirectory=/var/www/CTFd
ExecStart=gunicorn --bind 0.0.0.0:5000 --keep-alive 2 --workers 3 --worker-class gevent 'CTFd:create_app()'
Restart=always

[Install]
WantedBy=multi-user.target
""" > /etc/systemd/system/ctfd.service
systemctl daemon-reload
sudo systemctl enable ctfd
sudo systemctl start ctfd

# Setting reverse proxy
echo """
{
    auto_https off
}
http://:80 {
    reverse_proxy localhost:5000 
}
""" > /etc/caddy/Caddyfile

cd /etc/caddy/
caddy reload

# replace config 
sed -i "s/REDIS_URL =/REDIS_URL = redis:\/\/localhost:6379/g" /var/www/CTFd/CTFd/config.ini
sudo systemctl restart ctfd