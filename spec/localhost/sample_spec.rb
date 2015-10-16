require 'spec_helper'

describe command('ruby --version') do
  it { should return_stdout '2.2.3' }
end

