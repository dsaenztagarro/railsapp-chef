#
# Cookbook Name:: rubystack
# Recipe:: web_server_install_sites
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

deployer = data_bag_item(:users, 'deployer')

node['web_server']['sites'].each do |site|
  passenger_site 'creating_site' do
    document_root site['document_root']
    environment 'USER' => deployer['id'], 'HOME' => deployer['home']
    server_name site['server_name']
    server_alias site['server_alias']
    friendly_error_pages site['friendly_error_pages']
    user deployer['id']
  end

  passenger_site 'enabling_site' do
    server_name site['server_name']
    user deployer['id']
    action :enable
  end
end
