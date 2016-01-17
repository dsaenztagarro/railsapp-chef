default['rubystack']['ruby_version'] = 'ruby-2.3.0'
default['rails_apps'] = []

override['rvm']['user']['name'] = 'deployer'
override['rvm']['user']['home'] = '/home/deployer'
override['rvm']['keyserver'] = '213.133.103.71'

default['apache']['run_group'] = 'www-data'

# Examples:
#
# default['rails_apps'] = [
#   {
#     deploy_dir: '/var/www/myfamilyweb',
#     rails_env: 'production',
#     database: {
#       adapter: 'postgresql',
#       hostname: 'localhost',
#       name: 'myfamilyweb',
#       password: 'myfamilyweb',
#       username: 'myfamilyweb'
#     },
#     secrets: {
#       secret_key_base: 'abcdefghijklmnopqrstuvwxyz0123456789'
#     }
#   }
# ]
