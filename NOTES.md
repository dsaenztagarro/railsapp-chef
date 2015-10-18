# Test-Kitchen workflow

Find vagrant boxes to be used by test-kitchen locally

```
vagrant box list
```

Edit `.kitchen.yml` to point to local vagrant box for speeding up tests

```
# ...
platforms:
  - name: ubuntu-14.04
    driver:
      box: ubuntu-14.04
```

# Development

Setup ChefDK environment with: `rvm use system && chef shell-init bash`

Use kitchens to check work in progress

```
kitchen list
kitchen create <kitchen.instance>
kitchen converge <kitchen.instance>
kitchen login <kitchen.instance>

# all steps in one
kitchen test <kitchen.instance>
```

# Tests

Run unit tests with: `rspec`

Use **chefspec** unit tests to test complex logic on including recipes.

Run **serverspec** and **bats** integration tests with: `kitchen test <kitchen.instance>`

# Documentation

[serverspec](http://serverspec.org/)
[tips](http://jtimberman.housepub.org/blog/categories/quicktips/)