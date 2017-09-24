#!/bin/sh
sudo apt-get update
wget https://raw.githubusercontent.com/dokku/dokku/v0.10.4/bootstrap.sh
sudo DOKKU_TAG=v0.10.4 bash bootstrap.sh
dokku apps:create dokku-demo
dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo
dokku mongo:create dokku-demo-db
dokku mongo:link dokku-demo-db dokku-demo
dokku config:set dokku-demo DOKKU_NGINX_PORT=80
