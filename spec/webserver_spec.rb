require 'spec_helper'

describe 'railsapp::webserver' do
  let(:server) { 'mywebapp.test' }
  let(:document_root) { '/var/www/mywebapp/public' }
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['railsapp']['webserver']['name'] = server
      node.set['railsapp']['webserver']['document_root'] = document_root
    end.converge described_recipe
  end

  it 'includes the `phusionpassenger` recipe' do
    expect(chef_run).to include_recipe('phusionpassenger')
  end

  it 'creates a new passenger site' do
    expect(chef_run).to(
      create_passenger_site('creating_site').with(
        server: server,
        document_root: document_root))
  end

  it 'enables a new passenger site' do
    expect(chef_run).to(
      enable_passenger_site('enabling_site').with(server: server))
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
