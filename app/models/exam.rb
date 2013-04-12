# == Schema Information
#
# Table name: exams
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  date         :date
#  kind         :string(255)
#  weight       :float
#  average      :float
#  grades_count :integer
#  section_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Exam < ActiveRecord::Base
  has_many :grades, dependent: :destroy
  belongs_to :section

  attr_accessible :date, :kind, :name, :weight, :section_id

  def update_average
    if grades_count > 0
      self.average = grades.sum(:mark) / grades_count
      save!
    end
  end
end
