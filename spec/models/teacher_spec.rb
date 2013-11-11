require 'spec_helper'

describe Teacher do

  describe 'relations' do
    it { should have_many(:courses) }
    it { should have_many(:course_teachers) }
  end

  describe '#to_s' do
    let(:name) { %w(mon professeur prefere).sample }
    let(:teacher) { build :teacher, name: name }
    subject { teacher.to_s }
    it { should eq name }
  end

end