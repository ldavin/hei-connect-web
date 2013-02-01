class Update < ActiveRecord::Base
  OBJECT_USER = :user
  OBJECT_SCHEDULE = :schedule
  OBJECTS = [OBJECT_USER, OBJECT_SCHEDULE]

  STATE_UNKNOWN = 'unknown'
  STATE_UPDATING = 'updating'
  STATE_OK = 'ok'
  STATE_FAILED = 'failed'
  STATES = [STATE_UNKNOWN, STATE_UPDATING, STATE_OK, STATE_FAILED]

  belongs_to :user
  attr_accessible :rev, :state, :object, :user_id

  after_initialize :set_default_state

  private

  def set_default_state
    if self.state.blank?
      self.state = STATE_UNKNOWN
    end
  end
end
