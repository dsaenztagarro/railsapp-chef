require 'spec_helper'

describe 'rubystack::web_server_install_sites' do
  let(:server_name) { 'mywebapp.test' }
  let(:username) { 'deployer' }
  let(:site_attributes) do
    { server_name: server_name,
      server_alias: %w(mywebapp.test),
      document_root: '/var/www/mywebapp/public',
      friendly_error_pages: true }
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['web_server']['sites'] = [site_attributes]
    end.converge described_recipe
  end

  before(:each) do
    stub_data_bag_item(:users, 'deployer').and_return(
      id: username,
      home: '/home/deployer',
      password: '$1$u8VO7mUh$sN6JdmyJ094zso8nDLRmI/'
    )
  end

  it 'creates a new passenger site with valid site attributes' do
    expect(chef_run).to(
      create_passenger_site('creating_site').with(site_attributes))
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
