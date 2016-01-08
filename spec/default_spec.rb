require 'spec_helper'

describe 'rubystack::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['database']['postgresql']['version'] = '9.3'
      node.set['rails_apps'] = []
    end.converge described_recipe
  end

  before(:each) do
    stub_data_bag_item(:users, 'deployer').and_return(
      id: 'deployer',
      home: '/home/deployer',
      password: '$1$u8VO7mUh$sN6JdmyJ094zso8nDLRmI/',
      shell: '/bin/bash'
    )
    commands = [
      'which rvm',
      'grep -q rvm $HOME/.bashrc',
      'ls /var/lib/postgresql/9.3/main/recovery.conf',
      'which node',
      "sudo apt-key list | grep \"PostgreSQL Debian Repository\""
    ]
    commands.each { |command| stub_command(command).and_return(false) }
  end

  %w(users
     system_requirements
     database
     web_server
     web_server_install_sites).each do |recipe|
    it "includes the `rubystack::#{recipe}` recipe" do
      expect(chef_run).to include_recipe("rubystack::#{recipe}")
    end
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end
