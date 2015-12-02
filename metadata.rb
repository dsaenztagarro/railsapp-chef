name             'railsapp'
maintainer       'David Saenz Tagarro'
maintainer_email 'david.saenz.tagarro@gmail.com'
license          'All rights reserved'
description      'Installs/Configures railsapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'build-essential'
depends 'database_sl'
depends 'rvm_sl'
depends 'phusionpassenger'

%w(debian ubuntu).each { |os| supports os }

source_url 'https://github.com/dsaenztagarro/railsapp' if respond_to?(:source_url)
issues_url 'https://github.com/dsaenztagarro/railsapp/issues' if respond_to?(:issues_url)
