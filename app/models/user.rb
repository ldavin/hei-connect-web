class User < ActiveRecord::Base

  STATE_UNVERIFIED = 'unverified'
  STATE_ACTIVE = 'active'
  STATE_INVALID = 'invalid'
  STATES = [STATE_UNVERIFIED, STATE_ACTIVE, STATE_INVALID]

  STATE_UNKNOWN = 'unknown'
  STATE_PLANNED = 'planned'
  STATE_OK = 'ok'
  SCHEDULE_STATES = [STATE_UNKNOWN, STATE_PLANNED, STATE_OK]

  has_many :weeks, dependent: :destroy

  validates :ecampus_id, :encrypted_password, presence: true
  validates :password, presence: true, on: :create
  validates :ecampus_id, length: {is: 6}
  validates :ecampus_id, uniqueness: true
  validates :state, :inclusion => {in: STATES}
  validates :schedule_state, :inclusion => {in: SCHEDULE_STATES}

  before_create :set_default_states
  after_create :set_ics_key

  attr_accessible :ecampus_id, :password
  attr_protected :state, :schedule_state
  attr_encrypted :password, key: ATTR_ENCRYPTED_KEY['user_password']

  def expired_schedule?
    true if self.weeks.any? and self.weeks.first.updated_at + 2.hours < Time.now and not self.schedule_planned?
  end

  def update_schedule!
    self.schedule_planned!
    FetchScheduleWorker.new.perform self.id
  end

  def to_s
    self.ecampus_id
  end

  def self.authenticate(id, password)
    user = User.find_or_initialize_by_ecampus_id id
    if user.password == password
      user
    else
      nil
    end
  end

  STATES.each do |state|
    define_method("#{state}?") do
      self.state == state
    end

    define_method("#{state}!") do
      self.update_attribute(:state, state)
    end

    scope state.to_sym, where(state: state)
  end

  SCHEDULE_STATES.each do |state|
    define_method("schedule_#{state}?") do
      self.schedule_state == state
    end

    define_method("schedule_#{state}!") do
      self.update_attribute(:schedule_state, state)
    end

    scope ('schedule_' + state).to_sym, where(schedule_state: state)
  end

  private

  def set_default_states
    self.state = STATES.first
    self.schedule_state = SCHEDULE_STATES.first
  end

  def set_ics_key
    self.update_attribute(:ics_key, Digest::MD5.hexdigest("#{self.id}-#{Random.rand}"))
  end
end
