#!/bin/bash

RAILS_ENV=development bundle exec rake assets:precompile

bundle exec puma -C config/puma.rb
