require 'spec_helper'

describe 'rubystack::web_server_install_sites' do
  let(:document_root) { '/var/www/mywebapp/public' }
  let(:server_name) { 'mywebapp.test' }
  let(:server_alias) { %w(mywebapp.test) }
  let(:username) { 'deployer' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['web_server']['sites'] = [
        { server_name: server_name,
          server_alias: server_alias,
          document_root: document_root,
          friendly_error_pages: true }
      ]
    end.converge described_recipe
  end

  before(:each) do
    stub_data_bag_item(:users, 'deployer').and_return(
      id: username,
      home: '/home/deployer',
      password: '$1$u8VO7mUh$sN6JdmyJ094zso8nDLRmI/'
    )
  end

  it 'creates a new passenger site' do
    expect(chef_run).to(
      create_passenger_site('creating_site').with(
        server_name: server_name,
        server_alias: server_alias,
        document_root: document_root,
        user: username))
  end

  it 'enables a new passenger site' do
    expect(chef_run).to(
      enable_passenger_site('enabling_site').with(
        server_name: server_name,
        user: username))
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
