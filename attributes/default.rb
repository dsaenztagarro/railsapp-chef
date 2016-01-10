default['rubystack']['ruby_version'] = 'ruby-2.3.0'
default['rails_apps'] = []

override['rvm']['user']['name'] = 'deployer'
override['rvm']['user']['home'] = '/home/deployer'
override['rvm']['keyserver'] = '213.133.103.71'
