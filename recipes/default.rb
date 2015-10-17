#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end

# node.default['rvm']['default_ruby'] = 'ruby-2.2.3'
# node.default['rvm']['user_default_ruby'] = 'ruby-2.2.3'
# include_recipe 'rvm::system'

include_recipe 'railsapp::setup_database'

