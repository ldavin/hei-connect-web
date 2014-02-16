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

require 'spec_helper'

describe Absence do
  let(:absence) { build :absence }

  describe 'relations' do
    it { should belong_to(:section) }
    it { should belong_to(:user_session) }
  end

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

  describe '#to_detailed_hash' do
    let(:section) { create :section, name: 'Chimie' }
    let(:absence) { build :absence, section_id: section.id, date: DateTime.new(2013, 10, 24, 11, 00, 00, +7),
                                    length: 90, excused: true, justification: 'justif'}

    subject { absence.to_detailed_hash }

    its([:matiere]) { should eq 'Chimie' }
    its([:date]) { should eq '24/10/2013 13h00' }
    its([:duree]) { should eq 90 }
    its([:type]) { should eq 'Excusée' }
    its([:raison]) { should eq 'justif' }
  end
end
