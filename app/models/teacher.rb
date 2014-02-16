# == Schema Information
#
# Table name: teachers
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_teachers_on_name  (name)
#

class Teacher < ActiveRecord::Base
  has_many :course_teachers, dependent: :delete_all
  has_many :courses, through: :course_teachers

  attr_accessible :name

  def to_s
    self.name
  end
end
