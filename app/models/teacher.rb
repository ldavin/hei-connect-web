# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Teacher < ActiveRecord::Base
  has_many :course_teachers, dependent: :delete_all
  has_many :courses, through: :course_teachers

  attr_accessible :name

  def to_s
    self.name
  end
end
