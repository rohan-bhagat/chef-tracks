#!/bin/bash
#configuring and setting up bundler
mv /tmp/database.yml /opt/tracks/current/config/database.yml
mv /tmp/site.yml /opt/tracks/current/config/site.yml
#workaround to fix symlink issues during bundle exec 
mkdir /opt/{log,pids}
#change wor dir
cd /opt/tracks/current
bundle exec rake db:migrate RAILS_ENV=production
bundle exec rake assets:precompile RAILS_ENV=production
bundle exec rails server -e production
