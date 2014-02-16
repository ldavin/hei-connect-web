# == Schema Information
#
# Table name: sections
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sections_on_name  (name)
#

class Section < ActiveRecord::Base
  has_many :courses, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :absences, dependent: :destroy

  attr_accessible :name
end
