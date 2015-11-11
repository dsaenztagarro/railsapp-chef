#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

execute 'apt-get update' do
  action :run
end

package 'apache2'

node.default['rvm']['user']['name'] = 'admin'
node.default['rvm']['user']['password'] = 'admin'
node.default['rvm']['user']['dir'] = '/home/admin'

node.default['rvm']['rubies']['version'] = '2.2.3'

include_recipe 'rvm::user_install'
include_recipe 'rvm::rubies'

%w(database webserver).each do |component|
  include_recipe "railsapp::setup_#{component}"
end



