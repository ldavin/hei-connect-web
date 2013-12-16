# == Schema Information
#
# Table name: course_rooms
#
#  id        :integer          not null, primary key
#  course_id :integer
#  room_id   :integer
#

require 'spec_helper'

describe CourseRoom do

  describe 'relations' do
    it { should belong_to(:course) }
    it { should belong_to(:room) }
  end

end
