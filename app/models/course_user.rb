class CourseUser < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  attr_accessible :update_number
end
