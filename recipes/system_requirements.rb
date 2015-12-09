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

ruby_version = node['railsapp']['ruby_version']

include_recipe 'rvm_sl::user_install'

rvm_rubies ruby_version do
  default true
end

rvm_gem 'bundler' do
  ruby_version ruby_version
end
