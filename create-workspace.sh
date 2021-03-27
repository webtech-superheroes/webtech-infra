#!/bin/bash
USERNAME="familyguy"
PASSWORD="web19"
SERVER_IP="127.0.1.42"
REPO="https://github.com/ionalexandru99/WebTech"

cd /var/www/workspaces
cp -R /var/www/workspaces/template /var/www/workspaces/$USERNAME
chown -R 1000:1000 /var/www/workspaces/$USERNAME/project

sed -i -e "s/{username}/$USERNAME/g" /var/www/workspaces/$USERNAME/project/README.md

git clone $REPO /var/www/workspaces/$USERNAME/project/app
chown -R 1000:1000 /var/www/workspaces/$USERNAME/project/app

cd /var/www/workspaces/$USERNAME
sed -i -e "s/{server_ip}/$SERVER_IP/g" /var/www/workspaces/$USERNAME/docker-compose.yml
docker-compose up -d

sudo htpasswd -b -c /etc/apache2/.htpasswd-$USERNAME $USERNAME $PASSWORD


cp /etc/nginx/sites-available/template-ide /etc/nginx/sites-available/$USERNAME-ide
sed -i -e "s/{username}/$USERNAME/g" -e "s/{server_ip}/$SERVER_IP/g" /etc/nginx/sites-available/$USERNAME-ide
ln -s /etc/nginx/sites-available/$USERNAME-ide /etc/nginx/sites-enabled/$USERNAME-ide

cp /etc/nginx/sites-available/template-app /etc/nginx/sites-available/$USERNAME-app
sed -i -e "s/{username}/$USERNAME/g" -e "s/{server_ip}/$SERVER_IP/g" /etc/nginx/sites-available/$USERNAME-app
ln -s /etc/nginx/sites-available/$USERNAME-app /etc/nginx/sites-enabled/$USERNAME-app
nginx -s reload