# == Schema Information
#
# Table name: course_users
#
#  id            :integer          not null, primary key
#  update_number :integer
#  course_id     :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe CourseUser do

  describe 'relations' do
    it { should belong_to(:course) }
    it { should belong_to(:user) }
  end

end
