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

apache_run_group = node['apache']['run_group']

execute 'setting_apache_run_group_as_primary_group' do
  command "usermod -g #{apache_run_group} #{deployer['id']}"
end
