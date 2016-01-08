[![Cookbook Version](https://img.shields.io/cookbook/v/rubystack.svg)](https://community.opscode.com/cookbooks/railsapp)
[![Build Status](https://travis-ci.org/dsaenztagarro/rubystack.svg?branch=master)](https://travis-ci.org/dsaenztagarro/railsapp)
[![Code Climate](https://codeclimate.com/github/dsaenztagarro/rubystack/badges/gpa.svg)](https://codeclimate.com/github/dsaenztagarro/railsapp)
[![Coverage Status](https://coveralls.io/repos/dsaenztagarro/rubystack/badge.svg?branch=master&service=github)](https://coveralls.io/github/dsaenztagarro/railsapp?branch=master)
[![Dependency Status](https://gemnasium.com/dsaenztagarro/rubystack.svg)](https://gemnasium.com/dsaenztagarro/railsapp)

rubystack Cookbook
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

#### rubystack::default

See `attributes/default.rb` for default values.

* `node['rubystack']['application']` - The application name
* `node['rubystack']['rails_env']` - The rails environment
* `node['rubystack']['deployer']['username']` - The deployer user name
* `node['rubystack']['deployer']['password']` - The deployer user password

Generate new password with:

```
openssl passwd -1 "theplaintextpassword"
```

#### rubystack::database

See `attributes/database.rb` for default values.

* `node['rubystack']['db']['name']` - The database name
* `node['rubystack']['db']['hostname']` - The hostname of the database
* `node['rubystack']['db']['username']` - The username of the database
* `node['rubystack']['db']['password']` - The password of the database

#### rubystack::webserver

See `attributes/webserver.rb` for default values.

* `node['rubystack']['webserver']['name']` - The server name
* `node['rubystack']['webserver']['document_root']` - The document root of the virtualhost

Usage
-----

#### rubystack::default

Just include `rubystack` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[rubystack]"
  ]
}
```

Sharing
-------

```
knife cookbook site share "rubystack" "Applications"
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
