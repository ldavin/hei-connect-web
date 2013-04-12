# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  ecampus_id      :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ics_key         :string(255)
#  password_digest :string(255)
#  token           :string(255)
#  last_activity   :datetime
#

class User < ActiveRecord::Base

  require 'bcrypt'

  has_many :course_users, dependent: :delete_all
  has_many :courses, through: :course_users
  has_many :updates, dependent: :delete_all
  has_many :sessions, class_name: "UserSession", dependent: :destroy, order: 'year DESC, try DESC'
  has_many :grades, through: :sessions

  validates :ecampus_id, presence: true
  validates :ecampus_id, length: {is: 6}
  validates :ecampus_id, uniqueness: true
  validates :password, presence: true, on: :create
  validates_presence_of :password_digest

  after_create :set_ics_key

  attr_reader :password
  attr_accessible :ecampus_id, :password

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def to_s
    self.ecampus_id
  end

  Update::OBJECTS.each do |object|
    object = object.to_s

    Update::STATES.each do |state|
      define_method "#{object}_rev" do |details = nil|
        fetch_update(object, details).rev
      end

      define_method "#{object}_rev_increment!" do |details = nil|
        update = fetch_update(object, details)
        update.rev += 1
        update.save!
        update.rev
      end

      define_method "#{object}_#{state}?" do |details = nil|
        fetch_update(object, details).state == state.to_s
      end

      define_method "#{object}_state" do |details = nil|
        fetch_update(object, details).state
      end

      define_method "#{object}_#{state}!" do |details = nil|
        update = fetch_update(object, details)
        update.state = state
        update.save!
      end

      define_method "#{object}_last_update" do |details = nil|
        fetch_update(object, details).updated_at
      end

      define_method "#{object}_update" do |details = nil|
        fetch_update(object, details)
      end
    end
  end

  def main_session
    self.sessions.order('year DESC, try DESC').limit(1).first
  end

  private

  def set_ics_key
    self.update_attribute(:ics_key, Digest::MD5.hexdigest("#{self.id}-#{Random.rand}"))
  end

  def fetch_update(object, details)
    # We try to find the update from the updates array, we create it if doesn't exist
    # Allow to take in account the "includes" in the queries
    self.updates.select { |u| u.object == object + details.to_s }.first ||
        self.updates.where(object: object + details.to_s).first_or_create
  end
end
