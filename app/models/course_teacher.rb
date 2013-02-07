# == Schema Information
#
# Table name: course_teachers
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  teacher_id :integer
#

class CourseTeacher < ActiveRecord::Base
  belongs_to :course
  belongs_to :teacher
end
