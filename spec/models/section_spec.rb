require 'spec_helper'

describe Section do

  describe 'relations' do
    it { should have_many(:courses) }
    it { should have_many(:exams) }
    it { should have_many(:absences) }
  end

end