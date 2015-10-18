source 'https://rubygems.org'

# Uncomment these lines if you want to live on the Edge:
#
# group :development do
#   gem "berkshelf", github: "berkshelf/berkshelf"
#   gem "vagrant", github: "mitchellh/vagrant", tag: "v1.6.3"
# end
#
# group :plugins do
#   gem "vagrant-berkshelf", github: "berkshelf/vagrant-berkshelf"
#   gem "vagrant-omnibus", github: "schisamo/vagrant-omnibus"
# end

gem 'librarian-chef'

group :test do
  gem 'reek'
  gem 'cane'
  gem 'chefspec', '~> 4.4.0'
  gem 'coveralls'
  gem 'foodcritic', '~> 5.0.0'
  gem 'rspec', '~> 3.3.0'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'test-kitchen', '~> 1.4.2'
end

group :integration do
  gem 'serverspec', '~> 2.24.1'
end

group :integration do
  gem 'berkshelf', '~> 4.0.1'
  gem 'kitchen-vagrant'
end
