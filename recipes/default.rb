#
# Cookbook Name:: rubystack
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

%w(users
   system_requirements
   database
   web_server
   web_server_install_sites).each do |recipe|
  include_recipe "rubystack::#{recipe}"
end
