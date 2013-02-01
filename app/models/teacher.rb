class Teacher < ActiveRecord::Base
  has_many :course_teachers, dependent: :delete_all
  has_many :courses, through: :course_teachers

  attr_accessible :name
end
