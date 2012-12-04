class User < ActiveRecord::Base
  validates :ecampus_id, :encrypted_password, presence: true
  validates :ecampus_id, length: {is: 6}
  validates :ecampus_id, uniqueness: true

  attr_accessible :ecampus_id, :firstname, :lastname
  attr_encrypted :password, key: ATTR_ENCRYPTED_KEY['user_password']
end
