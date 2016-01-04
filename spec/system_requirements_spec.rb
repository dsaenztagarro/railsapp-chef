require 'spec_helper'

describe 'railsapp::system_requirements' do
  let(:application) { 'webapp' }
  let(:deployer) { 'deployer' }
  let(:ruby_version) { '2.3.0' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['railsapp']['application'] = application
      node.set['railsapp']['deployer']['username'] = deployer
      node.set['railsapp']['ruby_version'] = ruby_version
    end.converge described_recipe
  end

  before(:each) do
    stub_command('which rvm').and_return(false)
    stub_command('grep -q rvm $HOME/.bashrc').and_return(false)
  end

  it 'runs a execute with apt-get update' do
    expect(chef_run).to run_execute('apt-get update')
  end

  it 'includes the `rvm_sl::user_install` recipe' do
    expect(chef_run).to include_recipe('rvm_sl::user_install')
  end

  it 'installs a git package with the default action' do
    expect(chef_run).to install_package('git')
  end

  it 'installs a apache2 package with the default action' do
    expect(chef_run).to install_package('apache2')
  end

  it 'installs valid ruby version' do
    expect(chef_run).to create_rvm_rubies(ruby_version)
  end

  it 'installs rvm gem bundler' do
    expect(chef_run).to create_rvm_gem('bundler').with(
      ruby_version: ruby_version
    )
  end
end
