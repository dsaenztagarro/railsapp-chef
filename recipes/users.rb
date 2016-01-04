#
# Cookbook Name:: rubystack
# Recipe:: users
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

deployer_username = node['rubystack']['deployer']['username']
deployer_password = node['rubystack']['deployer']['password']

user deployer_username do
  gid 'users'
  home "/home/#{deployer_username}"
  password deployer_password
  shell '/bin/bash'
  supports manage_home: true
  uid 1000
end

group 'www-data' do
  append true
  members deployer_username
  action :modify
end
