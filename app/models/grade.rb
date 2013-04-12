# == Schema Information
#
# Table name: grades
#
#  id              :integer          not null, primary key
#  mark            :float
#  unknown         :boolean
#  update_number   :integer
#  user_session_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  exam_id         :integer
#

class Grade < ActiveRecord::Base
  belongs_to :exam
  delegate :section, to: :exam

  belongs_to :user_session
  delegate :user, to: :user_session

  after_create :increment_exam_counter
  after_save :update_exam_average
  after_destroy :decrement_exam_counter

  attr_accessible :mark, :unknown, :update_number, :user_session_id, :exam_id

  private

  def increment_exam_counter
    Exam.increment_counter(:grades_count, exam_id)
  end

  def decrement_exam_counter
    # Surround by a begin rescue in case the exam has already been destroyed
    begin
      Exam.decrement_counter(:grades_count, exam_id)
      update_exam_average
    rescue
    end
  end

  def update_exam_average
    exam.update_average
  end
end
