# encoding: utf-8

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
  ADMIN_INCLUDES = [:section]
  ADMIN_INDEX_ATTRIBUTES = [
      :id,
      :section_id,
      {title: :section_name, irregular: true, value: lambda { |e| e.section.name }},
      :kind,
      {date: lambda { |a| a.date.strftime('%d/%m/%y') }},
      :average,
      :grades_count,
      {updated_at: lambda { |u| u.updated_at.strftime('%d/%m/%y à %H:%M') }}
  ]

  has_many :grades, dependent: :destroy
  belongs_to :section

  attr_accessible :date, :kind, :name, :weight, :section_id

  def update_average_and_counter
    self.grades_count = grades.known.count
    self.average = grades.known.sum(:mark) / grades_count if grades_count > 0
    save!
  end
end
