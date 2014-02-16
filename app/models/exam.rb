# encoding: utf-8
# == Schema Information
#
# Table name: exams
#
#  average      :float
#  created_at   :datetime         not null
#  date         :date
#  grades_count :integer
#  id           :integer          not null, primary key
#  kind         :string(255)
#  name         :string(255)
#  section_id   :integer
#  updated_at   :datetime         not null
#  weight       :float
#
# Indexes
#
#  index_exams_on_section_id  (section_id)
#

class Exam < ActiveRecord::Base
  has_many :grades, dependent: :destroy
  belongs_to :section

  attr_accessible :date, :kind, :name, :weight, :section_id

  def update_average_and_counter
    self.grades_count = grades.known.count
    self.average = grades.known.sum(:mark) / grades_count if grades_count > 0
    save!
  end
end
