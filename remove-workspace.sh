#!/bin/bash
USERNAME="ebu2020"

cd /var/www/workspaces/$USERNAME
docker-compose down

rm -r /var/www/workspaces/$USERNAME

rm /etc/nginx/sites-enabled/$USERNAME-app
rm /etc/nginx/sites-enabled/$USERNAME-ide

rm /etc/nginx/sites-available/$USERNAME-app
rm /etc/nginx/sites-available/$USERNAME-ide

nginx -s reload