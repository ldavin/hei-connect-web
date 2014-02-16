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

class CourseTeacher < ActiveRecord::Base
  belongs_to :course
  belongs_to :teacher
end
