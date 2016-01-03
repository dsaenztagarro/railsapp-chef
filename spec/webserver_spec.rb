require 'spec_helper'

describe 'railsapp::webserver' do
  let(:document_root) { '/var/www/mywebapp/public' }
  let(:server_name) { 'mywebapp.test' }
  let(:server_alias) { %w(mywebapp.test) }
  let(:username) { 'deployer' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['railsapp']['webserver']['server_name'] = server_name
      node.set['railsapp']['webserver']['server_alias'] = server_alias
      node.set['railsapp']['webserver']['document_root'] = document_root
      node.set['railsapp']['username'] = username
    end.converge described_recipe
  end

  it 'includes the `phusionpassenger` recipe' do
    expect(chef_run).to include_recipe('phusionpassenger')
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
