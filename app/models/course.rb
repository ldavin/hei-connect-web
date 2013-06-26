# encoding: utf-8

# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  date        :datetime
#  length      :integer
#  kind        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ecampus_id  :integer
#  section_id  :integer
#  group_id    :integer
#  broken_name :string(255)
#

class Course < ActiveRecord::Base
  ADMIN_INDEX_ATTRIBUTES = [
      :id,
      {date: lambda { |a| a.date.strftime('%d/%m/%y à %H:%M') }},
      :length,
      :kind,
      :ecampus_id,
      :section_id,
      :group_id,
      :broken_name,
      {created_at: lambda { |a| a.created_at.strftime('%d/%m/%y à %H:%M') }}
  ]

  UNKNOWN_PLACE = 'Lieu inconnu'
  UNKNOWN_DESCRIPTION = 'E-Campus ne donne pas plus d\'informations.'

  has_many :course_rooms, dependent: :delete_all
  has_many :rooms, through: :course_rooms
  has_many :course_teachers, dependent: :delete_all
  has_many :teachers, through: :course_teachers
  has_many :course_users, dependent: :delete_all
  has_many :users, through: :course_users

  belongs_to :section
  belongs_to :group

  attr_accessible :ecampus_id, :date, :length, :kind, :broken_name

  scope :current_weeks, lambda { where("date >= ?", Time.zone.now.beginning_of_week).order("date ASC") }

  def to_ical_event
    Rails.cache.fetch [self, 'ical_event'] do
      event = RiCal.Event
      event.dtstart = self.date
      event.dtend = self.date + self.length.minutes
      event.summary = self.name
      event.description = self.description
      event.location = self.place
      event.created = self.created_at.to_datetime
      event.last_modified = self.updated_at.to_datetime

      event
    end
  end

  def to_fullcalendar_event
    Rails.cache.fetch [self, 'full_calendar_event'] do
      {
          id: self.id,
          title: "#{name}, #{place}",
          start: self.date,
          end: self.date + self.length.minutes,
          allDay: false
      }
    end
  end

  def name
    if self.broken_name.present?
      self.broken_name
    else
      "#{self.kind} - #{self.section.name}"
    end
  end

  def description
    if self.broken_name.present?
      UNKNOWN_DESCRIPTION
    else
      desc = "#{self.kind} de #{self.section.name}"
      if self.teachers.any?
        desc += "\r\nPar #{self.teachers.join ', '}."
      end

      desc
    end
  end

  def place
    if self.rooms.any?
      self.rooms.join ', '
    else
      UNKNOWN_PLACE
    end
  end

end
