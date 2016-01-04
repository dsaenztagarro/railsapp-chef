default['rubystack']['application'] = 'webapp'
default['rubystack']['rails_env'] = 'production'
default['rubystack']['username'] = 'deployer'
default['rubystack']['ruby_version'] = 'ruby-2.2.3'

override['rvm']['user']['name'] = 'deployer'
override['rvm']['user']['home'] = '/home/deployer'
override['rvm']['keyserver'] = '213.133.103.71'
