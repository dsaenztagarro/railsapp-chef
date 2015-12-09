default['railsapp']['application'] = 'webapp'
default['railsapp']['rails_env'] = 'production'
default['railsapp']['username'] = 'deployer'
default['railsapp']['ruby_version'] = 'ruby-2.2.3'

override['rvm']['user']['name'] = 'deployer'
override['rvm']['user']['home'] = '/home/deployer'
