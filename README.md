[![Cookbook Version](https://img.shields.io/cookbook/v/railsapp-chef.svg)](https://community.opscode.com/cookbooks/railsapp-chef)
[![Build Status](https://travis-ci.org/dsaenztagarro/railsapp-chef.svg?branch=master)](https://travis-ci.org/dsaenztagarro/railsapp-chef)
[![Code Climate](https://codeclimate.com/github/dsaenztagarro/railsapp-chef/badges/gpa.svg)](https://codeclimate.com/github/dsaenztagarro/railsapp-chef)
[![Coverage Status](https://coveralls.io/repos/dsaenztagarro/railsapp-chef/badge.svg?branch=master&service=github)](https://coveralls.io/github/dsaenztagarro/railsapp-chef?branch=master)
[![Dependency Status](https://gemnasium.com/dsaenztagarro/railsapp-chef.svg)](https://gemnasium.com/dsaenztagarro/railsapp-chef)

railsapp Cookbook
=================

My skeleton cookbook for provisioning rails apps

This cookbook makes your favorite breakfast sandwich.

Requirements
------------

#### Platforms
- Ubuntu 14.04 LTS

#### Chef
- Chef 12.2.0

#### Cookbooks
- database_sl
- rvm_sl
- phussionpassenger

Attributes
----------

#### railsapp::default

See `attributes/default.rb` for default values.

* `node['railsapp']['application']` - The application name
* `node['railsapp']['rails_env']` - The rails environment
* `node['railsapp']['deployer']['username']` - The deployer user name
* `node['railsapp']['deployer']['password']` - The deployer user password

Generate new password with:

```
openssl passwd -1 "theplaintextpassword"
```

#### railsapp::database

See `attributes/database.rb` for default values.

* `node['railsapp']['db']['name']` - The database name
* `node['railsapp']['db']['hostname']` - The hostname of the database
* `node['railsapp']['db']['username']` - The username of the database
* `node['railsapp']['db']['password']` - The password of the database

#### railsapp::webserver

See `attributes/webserver.rb` for default values.

* `node['railsapp']['webserver']['name']` - The server name
* `node['railsapp']['webserver']['document_root']` - The document root of the virtualhost

Usage
-----

#### railsapp::default

Just include `railsapp` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[railsapp]"
  ]
}
```

Sharing
-------

```
knife cookbook site share "railsapp" "Applications"
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: David Saenz Tagarro
