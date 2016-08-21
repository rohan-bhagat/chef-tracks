#
# Cookbook Name:: tracks
# Recipe:: default
#
# Copyright 2016, Rohan Bhagat
#
# All rights reserved - Do Not Redistribute

#Deploying Tracks application
#first install the git package
package "git" do
        action:upgrade
end

#now perform git clone on the Tracks repo
deploy 'tracks' do
	repo 'https://github.com/TracksApp/tracks.git'
	deploy_to '/opt/tracks'
	action:deploy
end

# install the bundler to bundle the app
package "bundler mariadb-server mariadb-client zlib1g-dev libmysqlclient-dev libsqlite3-dev" do
	action:upgrade
end

#start and enable mysql service
service 'mysql' do
      supports :status => true
      action [:enable, :start]
end

#configure mysql root pass
#execute 'mysql_change_pass' do
#	command 'mysqladmin -u root password T3mPp@$$w0rd'
#end

#reload mysql to make effect for root pass
service 'mysql' do
      supports :status => true
      action [:restart]
end

#create database for tracks
cookbook_file '/tmp/tracks_db.sh' do
source 'tracks_db.sh'
user 'root'
mode "0755"
end

execute 'shell_script' do
command 'sh /tmp/tracks_db.sh'
end

#bundle install
execute 'bundle_install' do
cwd "/opt/tracks/current"
command "bundle install --without development test"
#action:nothing
end

#configurintion files
cookbook_file '/opt/tracks/current/config/database.yml' do
source 'database.yml'
mode '0644'
action :create_if_missing
#action :create
end





cookbook_file '/opt/tracks/current/config/site.yml' do
source 'site.yml'
mode '0644'
#action :create_if_missing
action :create
end

#deployment
execute 'populate_db_schema' do
cwd '/opt/tracks/current'
#populate db schema
command 'bundle exec rake db:migrate RAILS_ENV=production'
#precompile assets
command 'bundle exec rake assets:precompile RAILS_ENV=production'
#start the server
command 'bundle exec rails server -e production'
#action:nothing
end

