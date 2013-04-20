# encoding: utf-8

# == Schema Information
#
# Table name: course_users
#
#  id            :integer          not null, primary key
#  update_number :integer
#  course_id     :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CourseUser < ActiveRecord::Base
  ADMIN_INCLUDES = [:user, course: :section]
  ADMIN_INDEX_ATTRIBUTES = [
      :id,
      :course_id,
      {title: :course_name, irregular: true, value: lambda { |cu| cu.course.name }},
      :user_id,
      {title: :user_name, irregular: true, value: lambda { |cu| cu.user }},
      {created_at: lambda { |cu| cu.created_at.strftime('%d/%m/%y à %H:%M') }}
  ]

  belongs_to :course
  belongs_to :user

  attr_accessible :update_number
end
