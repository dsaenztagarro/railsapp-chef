#
# Cookbook Name:: rubystack
# Recipe:: webserver
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'phusionpassenger'

webserver = node['rubystack']['webserver']
username = node['rubystack']['username']

passenger_site 'creating_site' do
  document_root node['rubystack']['webserver']['document_root']
  environment 'USER' => username, 'HOME' => File.join('/home', username)
  server_name webserver['server_name']
  server_alias webserver['server_alias']
  user username
end

passenger_site 'enabling_site' do
  server_name webserver['server_name']
  user username
  action :enable
end
