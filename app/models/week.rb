class Week < ActiveRecord::Base
  belongs_to :user
  has_many :courses

  before_save :set_default_rev

  attr_accessible :number, :rev, :user_id

  private

  def set_default_rev
    self.rev = 1 if self.rev.nil?
  end
end
