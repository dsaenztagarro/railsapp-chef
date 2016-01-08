require 'spec_helper'

describe 'rubystack::database' do
  let(:postgresql_package_version) { '9.4+170.pgdg14.04+1' }
  let(:postgresql_version) { '9.4' }
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['database']['postgresql']['package_version'] = postgresql_package_version
      node.set['database']['postgresql']['version'] = postgresql_version
      node.set['rails_apps'] = [{
        database: {
          name: 'db_production',
          username: 'admin',
          password: 'admin1234'
        }
      }]
    end.converge described_recipe
  end

  before(:each) do
    stub_command("sudo apt-key list | grep \"PostgreSQL Debian Repository\"").and_return(false)
  end

  it 'installs postgresql db server' do
    expect(chef_run).to include_recipe 'database_sl::postgresql'
  end

  it 'installs specific version of db server on node' do
    packages = ['postgresql', 'postgresql-contrib']
    expect(chef_run).to install_package(packages).with(version: postgresql_package_version)
  end

  it 'installs specific version of db client on node' do
    expect(chef_run).to install_package('postgresql-client').with(version: postgresql_package_version)
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
    expect { chef_run }.to_not raise_error
  end
end
