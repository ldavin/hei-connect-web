# == Schema Information
#
# Table name: course_teachers
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  teacher_id :integer
#

class CourseTeacher < ActiveRecord::Base
  ADMIN_INCLUDES = [:teacher, course: :section]
  ADMIN_INDEX_ATTRIBUTES = [
      :id,
      :course_id,
      {title: :course_name, irregular: true, value: lambda { |ct| ct.course.name }},
      :teacher_id,
      {title: :teacher_name, irregular: true, value: lambda { |ct| ct.teacher.name }}
  ]

  belongs_to :course
  belongs_to :teacher
end
