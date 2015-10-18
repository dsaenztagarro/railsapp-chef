#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

db_name = node['railsapp']['db']['name']
db_user_name = node['railsapp']['db']['user']['name']

# Work-around: pg gem fails to compile with chef 12.0 #212
node.default['build-essential']['compile_time'] = true
include_recipe 'build-essential::default'

# Install database

node.default['postgresql']['version'] = '9.3'
node.default['postgresql']['password']['postgres'] = 'postgres'

# Added custom config for: /etc/postgresql/9.3/main/pg_hba.conf
# node.default['postgresql']['pg_hba'].concat([
#   {type: 'local', db: db_name, user: db_user_name, addr: '127.0.0.1/32', method: 'md5'},
# ])

include_recipe 'postgresql::server'
include_recipe 'postgresql::client'

# Configure database
#
# include_recipe 'database'
include_recipe 'database::postgresql'

postgresql_connection_info = {
  host: '127.0.0.1',
  port: node['postgresql']['config']['port'],
  username: 'postgres',
  password: node['postgresql']['password']['postgres']
}

# create a mysql user but grant no privileges
postgresql_database_user db_user_name do
  connection postgresql_connection_info
  password   node['railsapp']['db']['user']['password']
  action     :create
end

# Create database
postgresql_database db_name do
  connection postgresql_connection_info
  owner db_user_name
  action :create
end

# Grant all privileges
postgresql_database_user db_user_name do
  connection    postgresql_connection_info
  database_name db_name
  privileges    ['ALL PRIVILEGES']
  action        :grant
end
