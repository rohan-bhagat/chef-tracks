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
package "bundler" do
	action:upgrade
end
