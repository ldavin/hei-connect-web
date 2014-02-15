# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  enabled    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Feature do

  describe '#enabled?' do
    subject { Feature.example_enabled? }

    context 'creates the feature when it does not exist'  do
      before { Feature.where(key: 'example').destroy_all }
      it { should be_false }
    end

    context 'returns the right value when feature exists' do
      context 'and is true' do
        let!(:feature) {create :feature, key: 'example', enabled: true}
        it { should be_true }
      end

      context 'and is false' do
        let!(:feature) {create :feature, key: 'example', enabled: false}
        it { should be_false }
      end
    end
  end

  describe '#enable' do
    let!(:feature) {create :feature, key: 'example', enabled: false}
    before { Feature.enable_example }
    subject { Feature.example_enabled? }
    it { should be_true }
  end

  describe '#disable' do
    let!(:feature) {create :feature, key: 'example', enabled: true}
    before { Feature.disable_example }
    subject { Feature.example_enabled? }
    it { should be_false }
  end
end
