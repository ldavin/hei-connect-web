# == Schema Information
#
# Table name: user_sessions
#
#  id               :integer          not null, primary key
#  year             :integer
#  try              :integer          default(1)
#  absences_session :integer
#  grades_session   :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class UserSession < ActiveRecord::Base
  belongs_to :user, touch: true
  attr_accessible :absences_session, :grades_session, :try, :user_id, :year
end
