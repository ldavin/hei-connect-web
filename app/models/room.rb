class Room < ActiveRecord::Base
  has_many :course_rooms, dependent: :delete_all
  has_many :courses, through: :course_rooms

  attr_accessible :name
end
