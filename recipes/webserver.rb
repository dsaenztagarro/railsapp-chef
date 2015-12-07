#
# Cookbook Name:: railsapp
# Recipe:: webserver
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'phusionpassenger'

passenger_virtualhost 'railsapp' do
  server_name node['railsapp']['server']['name']
  user_name node['railsapp']['user']['name']
  document_root node['railsapp']['webserver']['document_root']
end

passenger_virtualhost 'railsapp' do
  server_name node['railsapp']['server']['name']
  user_name node['railsapp']['user']['name']
  action :enable
end
