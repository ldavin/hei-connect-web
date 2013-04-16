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

  attr_accessible :mark, :unknown, :update_number, :user_session_id, :exam_id

  scope :known, where(unknown: false)
end
