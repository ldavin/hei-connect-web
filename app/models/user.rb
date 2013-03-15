# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  ecampus_id         :string(255)
#  encrypted_password :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  ics_key            :string(255)
#  ecampus_user_id    :integer
#  ecampus_student_id :integer
#

class User < ActiveRecord::Base

  has_many :course_users, dependent: :delete_all
  has_many :courses, through: :course_users
  has_many :updates

  validates :ecampus_id, presence: true
  validates :password, :encrypted_password, presence: true, on: :create
  validates :ecampus_id, length: {is: 6}
  validates :ecampus_id, uniqueness: true

  after_create :set_ics_key

  attr_accessible :ecampus_id, :ecampus_student_id, :ecampus_user_id, :password
  attr_encrypted :password, key: ATTR_ENCRYPTED_KEY['user_password']

  def expired_schedule?
    true if not self.schedule_updating? and self.schedule_last_update + 4.hours < Time.now
  end

  def update_schedule!
    self.schedule_updating!
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

  Update::OBJECTS.each do |object|
    object = object.to_s

    Update::STATES.each do |state|
      define_method "#{object}_rev" do |details = nil|
        self.updates.where(object: object + details.to_s).first_or_create.rev
      end

      define_method "#{object}_rev_increment!" do |details = nil|
        update = self.updates.where(object: object + details.to_s).first_or_create
        update.rev += 1
        update.save!
        update.rev
      end

      define_method "#{object}_#{state}?" do |details = nil|
        self.updates.where(object: object + details.to_s).first_or_create.state == state.to_s
      end

      define_method "#{object}_state" do |details = nil|
        self.updates.where(object: object + details.to_s).first_or_create.state
      end

      define_method "#{object}_#{state}!" do |details = nil|
        update = self.updates.where(object: object + details.to_s).first_or_create
        update.state = state
        update.save!
      end

      define_method "#{object}_last_update" do |details = nil|
        self.updates.where(object: object + details.to_s).first_or_create.updated_at
      end
    end
  end

  private

  def set_ics_key
    self.update_attribute(:ics_key, Digest::MD5.hexdigest("#{self.id}-#{Random.rand}"))
  end

end
