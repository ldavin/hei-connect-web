# == Schema Information
#
# Table name: groups
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_groups_on_name  (name)
#

class Group < ActiveRecord::Base
  has_many :courses, dependent: :destroy

  attr_accessible :name

  def to_s
    self.name
  end
end
