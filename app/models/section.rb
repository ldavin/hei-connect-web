# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Section < ActiveRecord::Base
  has_many :courses, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :absences, dependent: :destroy

  attr_accessible :name
end
