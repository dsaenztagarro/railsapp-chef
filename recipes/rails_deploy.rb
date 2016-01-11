#
# Cookbook Name:: rubystack
# Recipe:: rails_deploy
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

apache_group = 'www-data'
deployer = data_bag_item(:users, 'deployer')
username = deployer['id']
home = deployer['home']

node['rails_apps'].each do |app|
  deploy_dir = app[:deploy_dir]

  %W(#{deploy_dir}
     #{deploy_dir}/shared
     #{deploy_dir}/shared/config).each do |path|
    directory path do
      group apache_group
      owner deployer['id']
      recursive true
    end
  end

  shared_config_dir = "#{deploy_dir}/shared/config"

  database_path = File.join shared_config_dir, 'database.yml'
  template 'create_database_config' do
    group apache_group
    owner deployer['id']
    path database_path
    source 'database.yml.erb'
    variables(
      rails_env: app[:rails_env],
      database: app[:database][:name],
      hostname: app[:database][:hostname],
      username: app[:database][:username],
      password: app[:database][:password]
    )
    not_if { ::File.exist? database_path }
  end

  secrets_path = File.join shared_config_dir, 'secrets.yml'
  template 'create_secrets_config' do
    group apache_group
    owner deployer['id']
    path secrets_path
    source 'secrets.yml.erb'
    variables(
      rails_env: app[:rails_env],
      secret_key_base: app[:secrets][:secret_key_base]
    )
    not_if { ::File.exist? secrets_path }
  end
end

# TODO: Extract to nodejs_sl cookbook
# include_recipe 'nodejs_sl'

tmp_node_installer_path = "#{Chef::Config[:file_cache_path]}/node_installer"

remote_file 'adding_node_installer' do
  path tmp_node_installer_path
  source 'https://deb.nodesource.com/setup_5.x'
  not_if { ::File.exist? tmp_node_installer_path }
end

execute 'running_node_source_setup_5X' do
  command "sudo -E bash #{tmp_node_installer_path}"
  cwd home
  environment 'USER' => username, 'HOME' => home
  user username
  not_if 'which node'
end

execute 'installing_nodejs' do
  command 'apt-get install -y nodejs'
  not_if 'which node'
end

execute 'installing_build_tools_for_nodejs' do
  command 'apt-get install -y build-essential'
end

# package 'nodejs'
