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

include_recipe 'database'
include_recipe 'database::postgresql'

postgresql_connection_info = {
  host: '127.0.0.1',
  port: node['postgresql']['config']['port'],
  username: 'postgres',
  password: node['postgresql']['password']['postgres']
}

db_name = node[:railsapp][:db][:name]
user_name = node[:railsapp][:db][:user][:name]

# create a mysql user but grant no privileges
postgresql_database_user user_name do
  connection postgresql_connection_info
  password   node[:railsapp][:db][:user][:password]
  action     :create
end

# Create database
postgresql_database db_name do
  connection postgresql_connection_info
  owner user_name
  action :create
end

# Grant all privileges
postgresql_database_user user_name do
  connection    postgresql_connection_info
  database_name db_name
  privileges    ['ALL PRIVILEGES']
  action        :grant
end
