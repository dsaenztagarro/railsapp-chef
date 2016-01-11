name             'rubystack'
maintainer       'David Saenz Tagarro'
maintainer_email 'david.saenz.tagarro@gmail.com'
license          'All rights reserved'
description      'Installs/Configures rubystack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.6'

depends 'database_sl'
depends 'rvm_sl'
depends 'phusionpassenger'

recipe 'rubystack::web_server_install', 'Installs Phusion Passenger web server'
recipe 'rubystack::web_server_sites', 'Enable ruby application web sites'

%w(debian ubuntu).each { |os| supports os }

source_url 'https://github.com/dsaenztagarro/rubystack' if respond_to?(:source_url)
issues_url 'https://github.com/dsaenztagarro/rubystack/issues' if respond_to?(:issues_url)
