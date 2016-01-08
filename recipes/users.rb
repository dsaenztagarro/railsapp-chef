#
# Cookbook Name:: rubystack
# Recipe:: users
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

deployer = data_bag_item(:users, 'deployer')

user deployer['id'] do
  gid 'users'
  home deployer['home']
  password deployer['password']
  shell '/bin/bash'
  supports manage_home: true
  uid 1000
end

group 'www-data' do
  append true
  members deployer['id']
  action :modify
end
