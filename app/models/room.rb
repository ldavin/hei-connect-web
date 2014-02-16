# == Schema Information
#
# Table name: rooms
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rooms_on_name  (name)
#

class Room < ActiveRecord::Base
  has_many :course_rooms, dependent: :delete_all
  has_many :courses, through: :course_rooms

  attr_accessible :name

  def to_s
    self.name
  end
end
