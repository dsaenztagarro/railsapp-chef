#
# Cookbook Name:: railsapp
# Recipe:: database
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

db_name = node['railsapp']['db']['name']
db_user_name = node['railsapp']['db']['user']['name']

include_recipe 'database_sl::postgresql'

postgresql_user 'creating_user' do
  name db_user_name
  password   node['railsapp']['db']['user']['password']
  action     :create
end

postgresql_database db_name do
  owner db_user_name
  action :create
end

postgresql_user 'granting_user' do
  name db_user_name
  database_name db_name
  privileges    ['ALL PRIVILEGES']
  action        :grant
end
