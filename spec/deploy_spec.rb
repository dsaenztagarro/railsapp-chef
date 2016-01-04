require 'spec_helper'

describe 'railsapp::deploy' do
  let(:apache_group) { 'www-data' }
  let(:application) { 'webapp' }
  let(:deployer) { 'deployer' }
  let(:deploy_dir) { "/var/www/#{application}" }

  let(:secrets_path) { "#{deploy_dir}/shared/config/secrets.yml" }
  let(:database_path) { "#{deploy_dir}/shared/config/database.yml" }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['railsapp']['application'] = application
      node.set['railsapp']['deployer']['username'] = deployer
    end.converge described_recipe
  end

  before(:each) do
    stub_command('which node').and_return(false)
  end

  context 'unconverged node' do
    it 'creates a deploy directory with valid attributes' do
      expect(chef_run).to create_directory(deploy_dir).with(
        user: deployer,
        group: apache_group
      )
    end

    it 'creates a shared deploy directory with valid attributes' do
      expect(chef_run).to create_directory("#{deploy_dir}/shared").with(
        user: deployer,
        group: apache_group
      )
    end

    it 'creates a shared config deploy directory with valid attributes' do
      dest_dir = "#{deploy_dir}/shared/config"
      expect(chef_run).to create_directory(dest_dir).with(
        user: deployer,
        group: apache_group
      )
    end

    it 'creates a database.yml template with attributes' do
      expect(chef_run).to create_template('create_database_config').with(
        user: deployer,
        group: apache_group,
        path: database_path
      )
    end

    it 'creates a secrets.yml template with attributes' do
      expect(chef_run).to create_template('create_secrets_config').with(
        user: deployer,
        group: apache_group,
        path: secrets_path
      )
    end

    it 'runs a execute with running node installer' do
      expect(chef_run).to run_execute('running_node_installer')
    end
  end

  context 'converged node' do
    before(:each) do
      allow(::File).to receive(:exist?).and_return(true)
      stub_command('which node').and_return(true)
    end

    it 'skips database config creation' do
      expect(chef_run).to_not create_template(database_path).with(
        user: deployer,
        group: apache_group,
        path: database_path
      )
    end

    it 'skips secrets config creation' do
      expect(chef_run).to_not create_template(secrets_path).with(
        user: deployer,
        group: apache_group,
        path: secrets_path
      )
    end

    it 'skips adding node installer' do
      expect(chef_run).to_not create_remote_file('adding_node_installer').with(
        path: "#{Chef::Config[:file_cache_path]}/node_installer"
      )
    end

    it 'skips running node installer' do
      expect(chef_run).to_not run_execute('running_node_installer').with(
        user: 'root'
      )
    end
  end
end
