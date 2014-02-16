# == Schema Information
#
# Table name: course_teachers
#
#  course_id  :integer
#  id         :integer          not null, primary key
#  teacher_id :integer
#
# Indexes
#
#  index_course_teachers_on_course_id   (course_id)
#  index_course_teachers_on_teacher_id  (teacher_id)
#

require 'spec_helper'

describe CourseTeacher do

  describe 'relations' do
    it { should belong_to(:course) }
    it { should belong_to(:teacher) }
  end

end
