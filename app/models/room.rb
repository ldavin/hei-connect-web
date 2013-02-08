# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ActiveRecord::Base
  has_many :course_rooms, dependent: :delete_all
  has_many :courses, through: :course_rooms

  attr_accessible :name

  def to_s
    self.name
  end
end
