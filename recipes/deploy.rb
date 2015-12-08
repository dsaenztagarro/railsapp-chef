#
# Cookbook Name:: railsapp
# Recipe:: deploy
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

deploy_dir = "/var/www/#{node['railsapp']['application']}"
deployer = node['railsapp']['deployer']['username']

directory deploy_dir do
  group 'www-data'
  owner deployer
  recursive true
end

directory "#{deploy_dir}/shared/config/" do
  group 'www-data'
  owner deployer
  recursive true
end

template "#{deploy_dir}/shared/config/database.yml" do
  group 'www-data'
  owner deployer
  source 'database.yml.erb'
  variables(
    rails_env: node['railsapp']['rails_env'],
    database: node['railsapp']['db']['name'],
    hostname: node['railsapp']['db']['hostname'],
    username: node['railsapp']['db']['username'],
    password: node['railsapp']['db']['password']
  )
end

template "#{deploy_dir}/shared/config/secrets.yml" do
  group 'www-data'
  owner deployer
  source 'secrets.yml.erb'
  variables(
    rails_env: node['railsapp']['rails_env'],
    secret_key_base: node['railsapp']['webserver']['secret_key_base']
  )
end

# TODO: Extract to nodejs_sl cookbook
# include_recipe 'nodejs_sl'

tmp_node_installer_path = "#{Chef::Config[:file_cache_path]}/node_installer"

remote_file 'adding_node_installer' do
  path tmp_node_installer_path
  source 'https://deb.nodesource.com/setup_5.x'
  not_if { ::File.exist? tmp_node_installer_path }
end

execute 'adding_apt_repository' do
  user 'root'
  command "sudo -E bash #{tmp_node_installer_path}"
  not_if 'which node'
end

package 'nodejs'
