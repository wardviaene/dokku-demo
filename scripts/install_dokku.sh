#!/bin/sh
wget https://raw.githubusercontent.com/dokku/dokku/v0.5.6/bootstrap.sh
sudo DOKKU_TAG=v0.5.6 bash bootstrap.sh
dokku apps:create dokku-demo
dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo
dokku mongo:create dokku-demo-db
dokku mongo:link dokku-demo-db dokku-demo
