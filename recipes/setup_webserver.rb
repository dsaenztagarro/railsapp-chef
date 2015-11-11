#
# Cookbook Name:: railsapp
# Recipe:: setup_webserver
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'phusionpassenger'

node.default['railsapp']['server_name'] = 'mydashboard.es'
node.default['railsapp']['application_path'] = '/www/deploy/batteries/current'

phusionpassenger_virtualhost 'railsapp' do
  server_name node['railsapp']['server_name']
  application_path node['railsapp']['application_path']
end

