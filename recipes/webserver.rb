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
deployer_username = node['rubystack']['deployer']['username']
deployer_home = node['rubystack']['deployer']['home']

passenger_site 'creating_site' do
  document_root node['rubystack']['webserver']['document_root']
  environment 'USER' => deployer_username, 'HOME' => deployer_home
  server_name webserver['server_name']
  server_alias webserver['server_alias']
  user deployer_username
end

passenger_site 'enabling_site' do
  server_name webserver['server_name']
  user deployer_username
  action :enable
end
