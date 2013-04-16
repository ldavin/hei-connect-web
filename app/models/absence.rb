# == Schema Information
#
# Table name: absences
#
#  id              :integer          not null, primary key
#  date            :datetime
#  length          :integer
#  excused         :boolean
#  justification   :string(255)
#  update_number   :integer
#  section_id      :integer
#  user_session_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Absence < ActiveRecord::Base
  belongs_to :section
  belongs_to :user_session
  delegate :user, to: :user_session

  attr_accessible :date, :excused, :justification, :length, :section_id, :update_number, :user_session_id

  scope :excused, where(excused: true)
  scope :justified, where('excused = ? AND justification IS NOT NULL', false)
  scope :nothing, where('excused = ? AND justification IS NULL', false)
end
