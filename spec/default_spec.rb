require 'chefspec'
require 'chefspec/berkshelf'

print Chef::Config[:cookbook_path]

describe 'railsapp::default' do
  # let (:cookbook_path) { %w(/Users/dst/Projects/chef/chef-repo/cookbooks/) }
  # let (:runner) { ChefSpec::SoloRunner.new(cookbook_path: cookbook_path) }
  let (:chef_run) do
    Kernel.stub(:require).with('rvm')
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04') do |node, server|
      node.set['postgresql']['version'] = '9.3'
    end.converge described_recipe
  end

  before(:each) do
    stub_command("ls /var/lib/postgresql/9.3/main/recovery.conf").and_return(true)
  end

  describe 'PostgreSQL' do
    it 'installs db server' do
      expect(chef_run).to include_recipe 'postgresql::server'
    end

    it 'installs expected version of db server' do
      expect(chef_run).to install_package('postgresql-9.3')
    end

    it 'installs db client' do
      expect(chef_run).to include_recipe 'postgresql::client'
    end

    it 'installs expected version of db client' do
      expect(chef_run).to install_package('postgresql-client-9.3')
    end
  end
end
