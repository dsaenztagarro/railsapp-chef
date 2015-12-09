#
# Cookbook Name:: railsapp
# Recipe:: users
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

deployer_username = node['railsapp']['deployer']['username']
deployer_password = node['railsapp']['deployer']['password']

user deployer_username do
  uid 1000
  gid 'users'
  supports manage_home: true
  home "/home/#{deployer_username}"
  shell '/bin/bash'
  password deployer_password
end

group 'www-data' do
  action :modify
  members deployer_username
  append true
end
