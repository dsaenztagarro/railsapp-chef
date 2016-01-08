require 'spec_helper'

describe 'rubystack::users' do
  let(:application) { 'webapp' }
  let(:apache_group) { 'www-data' }

  let(:deployer_id) { 'deployer' }
  let(:deployer_home) { '/home/deployer' }
  let(:deployer_password) { 'deployer123' }
  let(:deployer_shell) { '/bin/bash' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['rubystack']['application'] = application
    end.converge described_recipe
  end

  before(:each) do
    stub_data_bag_item(:users, 'deployer').and_return({
      id: deployer_id,
      home: deployer_home,
      password: deployer_password,
      shell: deployer_shell
    })
    stub_command('which rvm').and_return(false)
    stub_command('grep -q rvm $HOME/.bashrc').and_return(false)
  end

  it 'creates a deployer user with valid attributes' do
    expect(chef_run).to create_user(deployer_id).with(
      home: deployer_home,
      password: deployer_password,
      shell: deployer_shell
    )
  end

  it 'modifies apache group with appending the deployer user' do
    expect(chef_run).to modify_group(apache_group).with(
      append: true,
      members: [deployer_id]
    )
  end
end
