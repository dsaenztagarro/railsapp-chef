#
# Cookbook Name:: railsapp
# Recipe:: system_requirements
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

include_recipe 'rvm::user_install'

rvm_rubies 'ruby-2.2.3' do
	version '2.2.3'
	default true
end
