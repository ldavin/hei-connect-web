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

  let(:absence) { build :absence }

  describe '#type' do
    subject { absence.type }

    context 'when absence is excused' do
      let(:absence) { build :absence, excused: true }
      it { should eq Absence::TYPE_EXCUSED }
    end

    context 'when absence is justified' do
      let(:absence) { build :absence, excused: false }
      it { should eq Absence::TYPE_JUSTIFIED }
    end

    context 'when absence is baaaad' do
      let(:absence) { build :absence, excused: false, justification: '' }
      it { should eq Absence::TYPE_NOTHING }
    end
  end
end
