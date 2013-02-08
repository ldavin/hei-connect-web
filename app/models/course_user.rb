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
  belongs_to :course
  belongs_to :user

  attr_accessible :update_number
end
