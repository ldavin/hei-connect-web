# encoding: utf-8

# == Schema Information
#
# Table name: grades
#
#  id              :integer          not null, primary key
#  mark            :float
#  unknown         :boolean
#  update_number   :integer
#  user_session_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  exam_id         :integer
#

class Grade < ActiveRecord::Base
  ADMIN_INCLUDES = [exam: :section, user_session: :user]
  ADMIN_INDEX_ATTRIBUTES = [
      :id,
      :mark,
      :unknown,
      :exam_id,
      {title: :section_name, irregular: true, value: lambda { |g| g.section.name }},
      :user_session_id,
      {title: :user_name, irregular: true, value: lambda { |g| g.user }},
      :update_number,
      {updated_at: lambda { |u| u.updated_at.strftime('%d/%m/%y à %H:%M') }}
  ]

  belongs_to :exam
  delegate :section, to: :exam

  belongs_to :user_session
  delegate :user, to: :user_session

  attr_accessible :mark, :unknown, :update_number, :user_session_id, :exam_id

  scope :known, where(unknown: false)
end
