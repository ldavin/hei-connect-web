# encoding: utf-8
# == Schema Information
#
# Table name: user_sessions
#
#  absences_session :integer
#  created_at       :datetime         not null
#  grades_session   :integer
#  id               :integer          not null, primary key
#  try              :integer          default(1)
#  update_number    :integer
#  updated_at       :datetime         not null
#  user_id          :integer
#  year             :integer
#
# Indexes
#
#  index_user_sessions_on_user_id  (user_id)
#

class UserSession < ActiveRecord::Base
  has_many :grades, dependent: :destroy
  has_many :exams, through: :grades
  has_many :absences, dependent: :destroy

  belongs_to :user

  attr_accessible :absences_session, :grades_session, :try, :update_number, :user_id, :year

  def is_main_session?
    self == self.user.sessions.order('year DESC, try DESC').limit(1).first
  end

  def title
    # Write the title
    title = 'HEI' + self.year.to_s
    title += '-' + self.try.to_s if self.try > 1

    # Return it
    title
  end
end
