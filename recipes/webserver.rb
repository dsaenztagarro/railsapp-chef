#
# Cookbook Name:: railsapp
# Recipe:: webserver
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'phusionpassenger'

sname = node['railsapp']['webserver']['name']
uname = node['railsapp']['username']

passenger_virtualhost 'railsapp' do
  server_name sname
  user_name uname
  document_root node['railsapp']['webserver']['document_root']
end

passenger_virtualhost 'railsapp' do
  server_name sname
  user_name uname
  action :enable
end
