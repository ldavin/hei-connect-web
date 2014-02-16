# encoding: utf-8
# == Schema Information
#
# Table name: course_rooms
#
#  course_id :integer
#  id        :integer          not null, primary key
#  room_id   :integer
#
# Indexes
#
#  index_course_rooms_on_course_id  (course_id)
#  index_course_rooms_on_room_id    (room_id)
#

class CourseRoom < ActiveRecord::Base
  belongs_to :course
  belongs_to :room
end
