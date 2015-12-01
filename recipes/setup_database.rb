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

# Configure database
#
# include_recipe 'database'
include_recipe 'database_sl::postgresql'

# create a mysql user but grant no privileges
postgresql_user "#{db_user_name}_user(1)" do
  name db_user_name
  password   node['railsapp']['db']['user']['password']
  action     :create
end

# Create database
postgresql_database db_name do
  owner db_user_name
  action :create
end

# Grant all privileges
postgresql_user "#{db_user_name}_user(2)" do
  name db_name
  database_name db_name
  privileges    ['ALL PRIVILEGES']
  action        :grant
end
