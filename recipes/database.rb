#
# Cookbook Name:: rubystack
# Recipe:: database
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'database_sl::postgresql'

db_name = node['rubystack']['db']['name']
db_username = node['rubystack']['db']['username']

postgresql_user 'creating_user' do
  name db_username
  password   node['rubystack']['db']['password']
  action     :create
end

postgresql_database db_name do
  owner db_username
  action :create
end

postgresql_user 'granting_user' do
  name db_username
  database_name db_name
  privileges    ['ALL PRIVILEGES']
  action        :grant
end
