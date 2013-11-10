require 'spec_helper'

describe Teacher do

  describe 'relations' do
    it { should have_many(:courses) }
    it { should have_many(:course_teachers) }
  end

end