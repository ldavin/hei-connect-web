require 'spec_helper'

describe Grade do

  describe 'relations' do
    it { should belong_to(:exam) }
    it { should belong_to(:user_session) }
  end

  describe '#to_detailed_hash' do
    let(:section) { create :section, name: 'Chimie' }
    let(:exam)    { create :exam, name: 'Super exam', date: DateTime.new(2013, 10, 24), kind: 'DS',
                           weight: 20, section: section, average: 10 }
    let(:grade)   { build :grade, mark: 13.5, unknown: false, exam: exam }
    subject { grade.to_detailed_hash }

    its([:matiere]) { should eq 'Chimie' }
    its([:examen]) { should eq 'Super exam' }
    its([:type]) { should eq 'DS' }
    its([:date]) { should eq '24/10/2013' }
    its([:coefficient]) { should eq '20.00' }

    context 'when grade is known' do
      its([:note]) { should eq '13.50' }
      its([:moyenne]) { should eq '10.00' }
    end

    context 'when grade is NOT known' do
      let(:grade) { build :grade, unknown: true, exam: exam }
      its([:note]) { should eq '?' }
      its([:moyenne]) { should eq '10.00' }
    end

    context 'when exam average is NOT known' do
      let(:exam) { create :exam, name: 'Super exam', date: DateTime.new(2013, 10, 24), kind: 'DS',
                          weight: 20, section: section, average: nil }
      its([:note]) { should eq '13.50' }
      its([:moyenne]) { should eq '?' }
    end
  end

end