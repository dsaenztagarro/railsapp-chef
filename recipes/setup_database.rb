#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

# Install database

node.default['postgresql']['version'] = '9.3'
node.default['postgresql']['password']['postgres'] = 'postgres'

include_recipe 'postgresql::server'
include_recipe 'postgresql::client'

# Configure database
