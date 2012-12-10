class User < ActiveRecord::Base
  has_many :weeks
  has_many :courses

  validates :ecampus_id, :encrypted_password, presence: true
  validates :ecampus_id, length: {is: 6}
  validates :ecampus_id, uniqueness: true

  attr_accessible :ecampus_id, :firstname, :lastname, :login_checked, :password
  attr_encrypted :password, key: ATTR_ENCRYPTED_KEY['user_password']

  def self.authenticate(id, password)
    user = User.find_or_initialize_by_ecampus_id id
    if user.password == password
      user
    else
      nil
    end
  end
end
