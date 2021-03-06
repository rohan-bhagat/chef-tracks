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
package "bundler mariadb-server mariadb-client zlib1g-dev libmysqlclient-dev libsqlite3-dev nginx" do
	action:upgrade
end

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

#configuration files
#workaround to fix symlink error for database.yml and site.yml
cookbook_file '/tmp/database.yml' do
source 'database.yml'
mode '0644'
action :create_if_missing
#action :create
end


cookbook_file '/tmp/site.yml' do
source 'site.yml'
mode '0644'
action :create_if_missing
#action :create
end

#deployment
cookbook_file '/tmp/bundle_config.sh' do
source 'bundle_config.sh'
user 'root'
mode "0755"
end

execute 'bundle_script' do
command 'sh /tmp/bundle_config.sh'
end
#enable mysql service
service 'mysql' do
      supports :status => true
      action [:enable,]
end

#init script
cookbook_file '/etc/init.d/tracks' do
source 'tracks'
owner 'root'
group 'root'
mode '755'
action :create_if_missing
#action :create
end

#enable tracks as service
service 'tracks' do
      supports :status => true
      action [:enable, :start]
end

#reverse proxy config setup
cookbook_file '/tmp/default' do
source 'default'
owner 'root'
group 'root'
mode '644'
action :create_if_missing
end

#nginx service
service 'nginx' do
      supports :status => true
      action [:enable, :start]
end
