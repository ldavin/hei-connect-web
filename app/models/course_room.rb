class CourseRoom < ActiveRecord::Base
  belongs_to :course
  belongs_to :room
end
