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

include_recipe 'rvm_sl::user_install'

rvm_rubies 'ruby-2.2.3' do
	default true
end

rvm_gem 'bundler' do
  ruby_version 'ruby-2.2.3'
end
