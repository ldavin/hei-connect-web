require 'spec_helper'

describe CourseRoom do

  describe 'relations' do
    it { should belong_to(:course) }
    it { should belong_to(:room) }
  end

end