# == Schema Information
#
# Table name: updates
#
#  id         :integer          not null, primary key
#  object     :string(255)
#  state      :string(255)
#  rev        :integer          default(0)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Update < ActiveRecord::Base
  OBJECT_USER = :user
  OBJECT_SCHEDULE = :schedule
  OBJECT_SESSIONS = :sessions
  OBJECT_GRADES = :grades
  OBJECTS = [OBJECT_USER, OBJECT_SCHEDULE, OBJECT_SESSIONS, OBJECT_GRADES]

  STATE_UNKNOWN = 'unknown'
  STATE_SCHEDULED = 'scheduled'
  STATE_UPDATING = 'updating'
  STATE_OK = 'ok'
  STATE_FAILED = 'failed'
  STATES = [STATE_UNKNOWN, STATE_SCHEDULED, STATE_UPDATING, STATE_OK, STATE_FAILED]

  belongs_to :user, touch: true
  attr_accessible :rev, :state, :object, :user_id

  after_initialize :set_default_state

  private

  def set_default_state
    if self.state.blank?
      self.state = STATE_UNKNOWN
    end
  end
end
