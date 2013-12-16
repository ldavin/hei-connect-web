# == Schema Information
#
# Table name: course_teachers
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  teacher_id :integer
#

require 'spec_helper'

describe CourseTeacher do

  describe 'relations' do
    it { should belong_to(:course) }
    it { should belong_to(:teacher) }
  end

end
