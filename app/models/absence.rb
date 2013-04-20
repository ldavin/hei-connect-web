# encoding: utf-8

# == Schema Information
#
# Table name: absences
#
#  id              :integer          not null, primary key
#  date            :datetime
#  length          :integer
#  excused         :boolean
#  justification   :string(255)
#  update_number   :integer
#  section_id      :integer
#  user_session_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Absence < ActiveRecord::Base
  ADMIN_INCLUDES = [:section, user_session: :user]
  ADMIN_INDEX_ATTRIBUTES = [
      :id,
      {date: lambda { |a| a.date.strftime('%d/%m/%y à %H:%M') }},
      :length,
      :excused,
      :update_number,
      :section_id,
      {title: :section_name, irregular: true, value: lambda { |a| a.section.name }},
      :user_session_id,
      {title: :user, irregular: true, value: lambda { |a| a.user }}
  ]
  TYPE_EXCUSED = 'Excusée'
  TYPE_JUSTIFIED = 'Justifiée'
  TYPE_NOTHING = 'Non justifiée'

  belongs_to :section
  belongs_to :user_session
  delegate :user, to: :user_session

  attr_accessible :date, :excused, :justification, :length, :section_id, :update_number, :user_session_id

  scope :excused, where(excused: true)
  scope :justified, where('excused = ? AND justification IS NOT NULL', false)
  scope :nothing, where('excused = ? AND justification IS NULL', false)

  def type
    if excused
      TYPE_EXCUSED
    elsif justification.present?
      TYPE_JUSTIFIED
    else
      TYPE_NOTHING
    end
  end
end
