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
	deploy_to '/tmp/tracks'
	action:deploy
end
#now install the bundler to bundle the app
package "bundler mysql-client-5.5 mysql-server-5.5" do
	action:upgrade
end

mysql_service 'default' do
	port '3306'
	version '5.5'
	initial_root_password 'TempP@$$w0rD'
	action [ :create, :start]
end

#start and enable mysql service
#service 'mysql' do
#      supports :status => true
#      action [:enable, :start]
#end

#create mysql database
#mysql_database 'tracks' do
#  connection(
#    :host     => '127.0.0.1',
#    :username => 'root',
#    :password => 'TempP@$$w0rD'
#  )
#provider   Chef::Provider::Database::Mysql  
#action :create
#end
