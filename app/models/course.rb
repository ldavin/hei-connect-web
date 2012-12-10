class Course < ActiveRecord::Base
  belongs_to :week

  attr_accessible :code, :date, :group, :length, :name, :room, :teacher, :type, :week_id, :week_rev
end
