# == Schema Information
#
# Table name: course_rooms
#
#  id        :integer          not null, primary key
#  course_id :integer
#  room_id   :integer
#

class CourseRoom < ActiveRecord::Base
  belongs_to :course
  belongs_to :room
end
