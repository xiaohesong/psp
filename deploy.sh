#!/bin/bash

# sudo su postgres
# if [ "$( psql -tAc "SELECT 1 FROM pg_database WHERE datname='psp_dev'" )" = '1' ]
# then
#     echo "Database already exists"
# else
#     echo "Database does not exist"
# fi
# ssh-copy-id user@ip
PWD=$(pwd)
DC_ORIGIN_WORKSPACE='/home/pinee/www'
scp -r $PWD "${DC_ORIGIN_USER}@${DC_ORIGIN_IP}:${DC_ORIGIN_WORKSPACE}"
echo "当前的路径是$PWD,下面链接的路径是${DC_ORIGIN_USER}@${DC_ORIGIN_IP}"
ssh -t ${DC_ORIGIN_USER}@${DC_ORIGIN_IP} "cd ${DC_ORIGIN_WORKSPACE}/psp && docker-compose build && docker-compose up -d"

# docker-compose build
# docker-compose up -d

echo `pwd`

# if [ ! -z $1 ]; then
#   echo '数据库不存在'1
#   docker-compose run app rake db:create
#   docker-compose run app rake db:migrate
# fi
