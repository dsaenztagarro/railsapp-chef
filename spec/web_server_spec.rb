require 'spec_helper'

describe 'rubystack::web_server' do
  let(:application) { 'webapp' }
  # let(:deployer) { 'deployer' }
  # let(:ruby_version) { '2.3.0' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['rubystack']['application'] = application
      # node.set['users']['deployer']['username'] = deployer
      # node.set['rubystack']['ruby_version'] = ruby_version
    end.converge described_recipe
  end

  it 'includes the `phusionpassenger` recipe' do
    expect(chef_run).to include_recipe('phusionpassenger')
  end

  it 'installs a apache2 package with the default action' do
    expect(chef_run).to install_package('apache2')
  end
end
