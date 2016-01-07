#
# Cookbook Name:: rubystack
# Recipe:: web_server_sites
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

deployer_username = node['users']['deployer']['username']
deployer_home = node['users']['deployer']['home']

node['web_server']['sites'].each do |site|
  passenger_site 'creating_site' do
    document_root site['document_root']
    environment 'USER' => deployer_username, 'HOME' => deployer_home
    server_name site['server_name']
    server_alias site['server_alias']
    friendly_error_pages site['friendly_error_pages']
    user deployer_username
  end

  passenger_site 'enabling_site' do
    server_name site['server_name']
    user deployer_username
    action :enable
  end
end
