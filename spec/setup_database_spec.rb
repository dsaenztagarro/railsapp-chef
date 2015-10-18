require 'spec_helper'

describe 'railsapp::setup_database' do
  let(:chef_run) do
    Kernel.stub(:require).with('rvm')
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['postgresql']['version'] = '9.3'
      node.set['railsapp']['db']['name'] = 'db_production'
      node.set['railsapp']['db']['user']['name'] = 'admin'
      node.set['railsapp']['db']['user']['password'] = 'admin1234'
    end.converge described_recipe
  end

  before(:each) do
    stub_command('ls /var/lib/postgresql/9.3/main/recovery.conf').and_return(true)
  end

  it 'installs db server' do
    expect(chef_run).to include_recipe 'postgresql::server'
  end

  it 'installs specific version of db server on node' do
    expect(chef_run).to install_package('postgresql-9.3')
  end

  it 'installs db client' do
    expect(chef_run).to include_recipe 'postgresql::client'
  end

  it 'installs specific version of db client on node' do
    expect(chef_run).to install_package('postgresql-client-9.3')
  end

  it 'creates database user' do
  end

  it 'creates production database schema' do
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
