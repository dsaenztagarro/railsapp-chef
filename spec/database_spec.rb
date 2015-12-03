require 'spec_helper'

describe 'railsapp::database' do
  let(:chef_run) do
    allow(Kernel).to receive(:require).and_return('rvm')
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['database_sl']['postgresql']['version'] = '9.3'
      node.set['railsapp']['db']['name'] = 'db_production'
      node.set['railsapp']['db']['user']['name'] = 'admin'
      node.set['railsapp']['db']['user']['password'] = 'admin1234'
    end.converge described_recipe
  end

  before(:each) do
    stub_command('grep -q http://apt.postgresql.org/pub/repos/apt/ /etc/apt/sources.list.d/pgdg.list').and_return(false)
  end

  it 'installs postgresql db server' do
    expect(chef_run).to include_recipe 'database_sl::postgresql'
  end

  it 'installs specific version of db server on node' do
    expect(chef_run).to install_package('postgresql-9.3, postgresql-contrib-9.3, postgresql-server-dev-9.3')
  end

  it 'installs specific version of db client on node' do
    expect(chef_run).to install_package('postgresql-client-9.3')
  end

  it 'creates database user' do
    expect(chef_run).to create_postgresql_user('creating_user')
  end

  it 'creates production database schema' do
    expect(chef_run).to create_postgresql_database('db_production')
  end

  it 'grant privileges to database user' do
    expect(chef_run).to grant_postgresql_user('granting_user')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
