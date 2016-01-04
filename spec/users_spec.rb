require 'spec_helper'

describe 'rubystack::users' do
  let(:application) { 'webapp' }
  let(:deployer) { 'deployer' }
  let(:deployer_password) { 'deployer123' }
  let(:apache_group) { 'www-data' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['rubystack']['application'] = application
      node.set['rubystack']['deployer']['username'] = deployer
      node.set['rubystack']['deployer']['password'] = deployer_password
    end.converge described_recipe
  end

  before(:each) do
    stub_command('which rvm').and_return(false)
    stub_command('grep -q rvm $HOME/.bashrc').and_return(false)
  end

  it 'creates a deployer user with valid attributes' do
    expect(chef_run).to create_user(deployer).with(
      home: "/home/#{deployer}",
      password: deployer_password,
      shell: '/bin/bash'
    )
  end

  it 'modifies apache group with appending the deployer user' do
    expect(chef_run).to modify_group(apache_group).with(
      append: true,
      members: [deployer]
    )
  end
end
