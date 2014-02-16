# encoding: utf-8
# == Schema Information
#
# Table name: course_users
#
#  course_id     :integer
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  update_number :integer
#  updated_at    :datetime         not null
#  user_id       :integer
#
# Indexes
#
#  index_course_users_on_course_id  (course_id)
#  index_course_users_on_user_id    (user_id)
#

class CourseUser < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  attr_accessible :update_number
end
