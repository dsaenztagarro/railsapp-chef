#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

%w(system_requirements
   database
   webserver
   deploy).each do |recipe|
  include_recipe "railsapp::#{recipe}"
end
