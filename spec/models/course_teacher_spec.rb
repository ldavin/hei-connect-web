require 'spec_helper'

describe CourseTeacher do

  describe 'relations' do
    it { should belong_to(:course) }
    it { should belong_to(:teacher) }
  end

end