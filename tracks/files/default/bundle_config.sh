#!/bin/bash
#configuring and setting up bundler
mv /tmp/database.yml /opt/tracks/current/config/database.yml
mv /tmp/site.yml /opt/tracks/current/config/site.yml
#workaround to fix symlink issues during bundle exec 
mkdir -p /opt//tracks/shared/{log,pids}
#change work dir
cd /opt/tracks/current
bundle exec rake db:migrate RAILS_ENV=production
bundle exec rake assets:precompile RAILS_ENV=production
#configured to start the webserver via init.d
#bundle exec rails server -e production
#configure init script to run levels
cd /etc/init.d
update-rc.d tracks defaults 98 02
update-rc.d tracks enable
rm -f /tmp/bundle_config.sh
