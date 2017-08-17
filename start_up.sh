#!/bin/bash

bundle exec rake assets:precompile

if [ ! -z $1 ]; then
  echo '数据库不存在'1
  # RAILS_ENV=production bundle exec rake db:create
  docker-compose run app rake db:create
fi

RAILS_ENV=production bundle exec rake db:migrate
  # docker-compose run app rake db:migrate

bundle exec puma -C config/puma.rb
