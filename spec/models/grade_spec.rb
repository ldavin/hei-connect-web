require 'spec_helper'

describe Grade do

  describe 'relations' do
    it { should belong_to(:exam) }
    it { should belong_to(:user_session) }
  end

end