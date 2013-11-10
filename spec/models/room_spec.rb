require 'spec_helper'

describe Room do

  describe 'relations' do
    it { should have_many(:courses) }
    it { should have_many(:course_rooms) }
  end

end