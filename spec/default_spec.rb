require 'spec_helper'

describe 'railsapp::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['database']['postgresql']['version'] = '9.3'
      node.set['railsapp']['deployer']['username'] = 'deployer'
      node.set['railsapp']['deployer']['password'] = 'deployer'
    end.converge described_recipe
  end

  before(:each) do
    stub_command('which rvm').and_return(false)
    stub_command("grep -q rvm $HOME/.bashrc").and_return(false)
    stub_command('ls /var/lib/postgresql/9.3/main/recovery.conf').and_return(true)
    stub_command('which node').and_return(false)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end
