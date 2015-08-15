# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  api_last_activity :datetime
#  api_token         :string(255)
#  created_at        :datetime         not null
#  ecampus_id        :string(255)
#  email             :string(255)
#  ics_key           :string(255)
#  ics_last_activity :datetime
#  id                :integer          not null, primary key
#  is_demo           :boolean          default(FALSE)
#  last_activity     :datetime
#  password_digest   :string(255)
#  token             :string(255)
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_ecampus_id  (ecampus_id)
#  index_users_on_ics_key     (ics_key)
#

class User < ActiveRecord::Base
  require 'bcrypt'

  has_many :course_users, dependent: :delete_all
  has_many :courses, through: :course_users
  has_many :updates, dependent: :destroy
  has_many :sessions, -> { order 'year DESC, try DESC' }, class_name: "UserSession", dependent: :destroy
  has_many :grades, through: :sessions
  has_many :absences, through: :sessions

  validates :ecampus_id, presence: true
  validates :ecampus_id, length: {is: 6}
  validates :ecampus_id, uniqueness: true
  validates :password, presence: true, on: :create
  validates_presence_of :password_digest

  after_create :set_ics_key, :initialize_last_activity

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
    # Try to use an included collection of sessions
    main = sessions.sort { |x, y| y.year <=> x.year }.first
    main = self.sessions.order('year DESC, try DESC').limit(1).first if main.nil?

    main
  end

  def set_api_token
    self.update_attribute(:api_token, Digest::MD5.hexdigest("#{self.id}-#{Random.rand}")) if self.api_token.nil?
  end

  def is_eligible_for_schedule_update?
    has_used_web_app_recently? or has_used_mobile_app_recently? or has_used_ics_recently?
  end

  def is_eligible_for_absences_or_grades_update?
    has_used_web_app_recently? or has_used_mobile_app_recently?
  end

  private

  def has_used_mobile_app_recently?
    self.api_last_activity != nil && self.api_last_activity > DateTime.now - 2.weeks
  end

  def has_used_web_app_recently?
    self.last_activity != nil && self.last_activity > DateTime.now - 2.weeks
  end

  def has_used_ics_recently?
    self.ics_last_activity != nil && self.ics_last_activity > DateTime.now - 2.weeks
  end

  def set_ics_key
    self.update_attribute(:ics_key, Digest::MD5.hexdigest(self.ecampus_id))
  end

  def initialize_last_activity
    self.update_attribute(:last_activity, Time.zone.now)
  end

  def fetch_update(object, details)
    # We try to find the update from the updates array, we create it if doesn't exist
    # Allow to take in account the "includes" in the queries
    self.updates.select { |u| u.object == object + details.to_s }.first ||
        self.updates.where(object: object + details.to_s).first_or_create
  end
end
