class User < ActiveRecord::Base

  STATES = %w{ unverified active }

  has_many :weeks
  has_many :courses

  validates :ecampus_id, :encrypted_password, presence: true
  validates :ecampus_id, length: {is: 6}
  validates :ecampus_id, uniqueness: true
  validates :state, :inclusion => {in: STATES}

  before_validation :set_default_state

  attr_accessible :ecampus_id, :firstname, :lastname, :password
  attr_encrypted :password, key: ATTR_ENCRYPTED_KEY['user_password']

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
  end

  private

  def set_default_state
    self.state = STATES.first
  end
end
