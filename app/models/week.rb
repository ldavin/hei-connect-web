class Week < ActiveRecord::Base
  belongs_to :user
  attr_accessible :number
end
