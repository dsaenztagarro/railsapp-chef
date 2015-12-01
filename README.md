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
- apt
- build-essential
- database_sl
- rvm

Attributes
----------

#### railsapp::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['railsapp']['server_name']</tt></td>
    <td>String</td>
    <td>Url of the server hosting the rails app</td>
    <td><tt>application.chef</tt></td>
  </tr>
  <tr>
    <td><tt>['railsapp']['application_path']</tt></td>
    <td>String</td>
    <td>The file path the application is deployed</td>
    <td><tt>application.chef</tt></td>
  </tr>
</table>

Usage
-----
#### railsapp::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `railsapp` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[railsapp]"
  ]
}
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
