require 'spec_helper'

describe 'railsapp::webserver' do
  let(:chef_run) do
    allow(Kernel).to receive(:require).and_return('rvm')
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['railsapp']['server']['name'] = 'myapp.test'
      node.set['railsapp']['application']['path'] = '/www/deploy/myapp/releases/current'
    end.converge described_recipe
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
