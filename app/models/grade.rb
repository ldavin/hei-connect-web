# == Schema Information
#
# Table name: grades
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  date            :date
#  kind            :string(255)
#  weight          :float
#  mark            :float
#  unknown         :boolean
#  update_number   :integer
#  user_session_id :integer
#  section_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Grade < ActiveRecord::Base
  belongs_to :user_session
  belongs_to :section

  delegate :user, to: :section
  attr_accessible :date, :kind, :mark, :name, :section_id, :unknown, :update_number, :user_session_id, :weight
end
