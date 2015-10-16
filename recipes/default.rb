#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

node.default['rvm']['default_ruby'] = 'ruby-2.2.3'
node.default['rvm']['user_default_ruby'] = 'ruby-2.2.3'
include_recipe 'rvm::system'

node.default['postgresql']['version'] = '9.3'
node.default['postgresql']['password']['postgres'] = 'postgres'
include_recipe 'postgresql::server'
include_recipe 'postgresql::client'
