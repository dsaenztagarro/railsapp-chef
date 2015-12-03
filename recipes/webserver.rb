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
  application_path node['railsapp']['application']['path']
end
