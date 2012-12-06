class Course < ActiveRecord::Base
  belongs_to :week
  attr_accessible :code, :date, :group, :length, :name, :room, :teacher, :type
end
