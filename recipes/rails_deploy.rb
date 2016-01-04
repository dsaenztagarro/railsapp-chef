#
# Cookbook Name:: rubystack
# Recipe:: rails_deploy
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

apache_group = 'www-data'
deployer = node['rubystack']['deployer']['username']
deploy_dir = "/var/www/#{node['rubystack']['application']}"

directory deploy_dir do
  group apache_group
  owner deployer
  recursive true
end

%W(#{deploy_dir}/shared #{deploy_dir}/shared/config).each do |path|
  directory path do
    group apache_group
    owner deployer
    recursive true
  end
end

database_path = "#{deploy_dir}/shared/config/database.yml"
template 'create_database_config' do
  group apache_group
  owner deployer
  path database_path
  source 'database.yml.erb'
  variables(
    rails_env: node['rubystack']['rails_env'],
    database: node['rubystack']['db']['name'],
    hostname: node['rubystack']['db']['hostname'],
    username: node['rubystack']['db']['username'],
    password: node['rubystack']['db']['password']
  )
  not_if { ::File.exist? database_path }
end

secrets_path = "#{deploy_dir}/shared/config/secrets.yml"
template 'create_secrets_config' do
  group apache_group
  owner deployer
  path secrets_path
  source 'secrets.yml.erb'
  variables(
    rails_env: node['rubystack']['rails_env'],
    secret_key_base: node['rubystack']['webserver']['secret_key_base']
  )
  not_if { ::File.exist? secrets_path }
end

# TODO: Extract to nodejs_sl cookbook
# include_recipe 'nodejs_sl'

tmp_node_installer_path = "#{Chef::Config[:file_cache_path]}/node_installer"

remote_file 'adding_node_installer' do
  path tmp_node_installer_path
  source 'https://deb.nodesource.com/setup_5.x'
  not_if { ::File.exist? tmp_node_installer_path }
end

execute 'running_node_installer' do
  user 'root'
  command "sudo -E bash #{tmp_node_installer_path}"
  not_if 'which node'
end

# package 'nodejs'
