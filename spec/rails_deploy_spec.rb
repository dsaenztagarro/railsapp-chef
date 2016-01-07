require 'spec_helper'

describe 'rubystack::rails_deploy' do
  let(:apache_group) { 'www-data' }
  let(:application) { 'webapp' }
  let(:deployer) { 'deployer' }
  let(:deploy_dir) { "/var/www/#{application}" }
  let(:shared_config_dir) { "#{deploy_dir}/shared/config" }

  let(:secrets_path) { "#{shared_config_dir}/secrets.yml" }
  let(:database_path) { "#{shared_config_dir}/database.yml" }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['users']['deployer']['username'] = deployer
      node.set['rails_apps'] = [
        {
          deploy_dir: deploy_dir,
          rails_env: 'production',
          database: {
            hostname: 'localhost',
            name: 'myfamilyweb',
            password: 'dbuser123',
            username: 'dbuser'
          },
          secrets: {
            secret_key_base: '8d7d7213485b5b960f753222a5e3f2974aaa19c3c99c84b575c0d7db409dc093bbcc8c5f08ec77c1a057631b9df50d6679bd3873da7b28030ce23075d8ebc127'
          }
        }
      ]
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
