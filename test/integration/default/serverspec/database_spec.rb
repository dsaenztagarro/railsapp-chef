require 'spec_helper'

describe package('postgresql-9.3') do
  it { should be_installed }
end

describe package('postgresql-client-9.3') do
  it { should be_installed }
end
