# encoding: utf-8

# == Schema Information
#
# Table name: course_rooms
#
#  id        :integer          not null, primary key
#  course_id :integer
#  room_id   :integer
#

class CourseRoom < ActiveRecord::Base
  ADMIN_INCLUDES = [:room, course: :section]
  ADMIN_INDEX_ATTRIBUTES = [
      :id,
      :course_id,
      {title: :course_name, irregular: true, value: lambda { |cr| cr.course.name }},
      :room_id,
      {title: :room_name, irregular: true, value: lambda { |cr| cr.room.name }}
  ]

  belongs_to :course
  belongs_to :room
end
