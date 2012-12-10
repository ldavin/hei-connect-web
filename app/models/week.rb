class Week < ActiveRecord::Base
  belongs_to :user
  has_many :courses
  attr_accessible :number
end
