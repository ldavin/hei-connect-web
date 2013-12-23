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

  def to_detailed_hash
    {
        id: self.id,
        matiere: self.section.name,
        date: self.date.strftime('%d/%m/%Y %Hh%M'),
        duree: self.length,
        type: self.type,
        raison: self.justification
    }
  end
end
