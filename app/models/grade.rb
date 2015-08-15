# encoding: utf-8
# == Schema Information
#
# Table name: grades
#
#  created_at      :datetime         not null
#  exam_id         :integer
#  id              :integer          not null, primary key
#  mark            :float
#  unknown         :boolean
#  update_number   :integer
#  updated_at      :datetime         not null
#  user_session_id :integer
#
# Indexes
#
#  index_grades_on_exam_id          (exam_id)
#  index_grades_on_user_session_id  (user_session_id)
#

class Grade < ActiveRecord::Base
  belongs_to :exam
  delegate :section, to: :exam

  belongs_to :user_session
  delegate :user, to: :user_session

  attr_accessible :mark, :unknown, :update_number, :user_session_id, :exam_id

  scope :known, -> { where(unknown: false) }

  def to_detailed_hash
    {
      id: self.id,
      matiere: self.exam.section.name,
      examen: self.exam.name,
      type: self.exam.kind,
      date: self.exam.date.strftime('%d/%m/%Y'),
      coefficient: "%.2f" % self.exam.weight,
      note: self.unknown ? '?' : "%.2f" % self.mark,
      moyenne: self.exam.average == nil ? '?' : "%.2f" % self.exam.average
    }
  end
end
