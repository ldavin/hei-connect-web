require 'spec_helper'

describe Group do

  describe 'relations' do
    it { should have_many(:courses) }
  end

end