require 'spec_helper'

describe Group do

  describe 'relations' do
    it { should have_many(:courses) }
  end

  describe '#to_s' do
    let(:name) { %w(nan mais allo quoi).sample }
    let(:group) { build :group, name: name }
    subject { group.to_s }
    it { should eq name }
  end

end