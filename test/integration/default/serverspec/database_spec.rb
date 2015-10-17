require 'spec_helper'

describe 'PostgreSQL' do

  it 'is listening on port 5432' do
    expect(port(5432)).to be_listening
  end

  describe package('postgresql-9.3') do
    it { should be_installed }
  end

  describe package('postgresql-client-9.3') do
    it { should be_installed }
  end

end
