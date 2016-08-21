#!/bin/bash
#configuring and setting up bundler
cd /opt/tracks/current
bundle exec rake db:migrate RAILS_ENV=production
bundle exec rake assets:precompile RAILS_ENV=production
bundle exec rails server -e production
