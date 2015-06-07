# encoding: utf-8
# == Schema Information
#
# Table name: absences
#
#  created_at      :datetime         not null
#  date            :datetime
#  excused         :boolean
#  id              :integer          not null, primary key
#  justification   :string(255)
#  length          :integer
#  section_id      :integer
#  update_number   :integer
#  updated_at      :datetime         not null
#  user_session_id :integer
#
# Indexes
#
#  index_absences_on_section_id       (section_id)
#  index_absences_on_user_session_id  (user_session_id)
#

class Absence < ActiveRecord::Base
  TYPE_EXCUSED = 'Excusée'
  TYPE_JUSTIFIED = 'Justifiée'
  TYPE_NOTHING = 'Non justifiée'

  belongs_to :section
  belongs_to :user_session
  delegate :user, to: :user_session

  attr_accessible :date, :excused, :justification, :length, :section_id, :update_number, :user_session_id

  scope :excused, -> { where(excused: true) }
  scope :justified, -> { where('excused = ? AND justification IS NOT NULL', false) }
  scope :nothing, -> { where('excused = ? AND justification IS NULL', false) }

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
