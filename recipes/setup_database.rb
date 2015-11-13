#
# Cookbook Name:: railsapp
# Recipe:: setup_database
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

db_name = node['railsapp']['db']['name']
db_user_name = node['railsapp']['db']['user']['name']

# Install database

package %w(postgresql postgresql-contrib)

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
