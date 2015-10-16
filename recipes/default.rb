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
