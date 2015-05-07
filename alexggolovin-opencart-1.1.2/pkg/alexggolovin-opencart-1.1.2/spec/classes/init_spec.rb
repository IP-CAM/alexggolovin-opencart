require 'spec_helper'
describe 'opencart' do

  context 'with defaults for all parameters' do
    it { should contain_class('opencart') }
  end
end
