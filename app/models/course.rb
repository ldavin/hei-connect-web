class Course < ActiveRecord::Base
  belongs_to :week

  attr_accessible :code, :date, :group, :length, :name, :room, :teacher, :kind, :week_id, :week_rev

  scope :given_on, lambda { |date| {:conditions => ['date >= ? AND date <= ?', date.beginning_of_day, date.end_of_day]} }

  def to_ics
    event = Icalendar::Event.new
    event.start = self.date.to_datetime
    event.end = (self.date + self.length.minutes).to_datetime
    event.summary = self.name
    event.description = [self.kind, self.group, self.teacher].join ', '
    event.location = self.room
    event.klass = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    event
  end
end
