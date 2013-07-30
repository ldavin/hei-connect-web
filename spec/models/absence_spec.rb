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

require 'spec_helper'

describe Absence do

  it 'should be of correct type' do
    excused_absence =  FactoryGirl.build :absence, excused: true
    justified_absence =  FactoryGirl.build :absence, excused: false
    bad_absence =  FactoryGirl.build :absence, excused: false, justification: ''

    excused_absence.type.should == Absence::TYPE_EXCUSED
    justified_absence.type.should == Absence::TYPE_JUSTIFIED
    bad_absence.type.should == Absence::TYPE_NOTHING
  end
end
