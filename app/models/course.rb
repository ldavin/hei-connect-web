class Course < ActiveRecord::Base
  has_many :course_rooms, dependent: :delete_all
  has_many :rooms, through: :course_rooms
  has_many :course_teachers, dependent: :delete_all
  has_many :teachers, through: :course_teachers
  has_many :course_users, dependent: :delete_all

  belongs_to :section
  belongs_to :group

  attr_accessible :ecampus_id, :date, :length, :kind

  #def to_ics
  #  event = Icalendar::Event.new
  #  event.start = self.date.to_datetime
  #  event.end = (self.date + self.length.minutes).to_datetime
  #  event.summary = self.name
  #  event.description = [self.kind, self.group, self.teacher].join ', '
  #  event.location = self.room
  #  event.klass = "PUBLIC"
  #  event.created = self.created_at
  #  event.last_modified = self.updated_at
  #  event
  #end
end
