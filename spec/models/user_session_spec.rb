# == Schema Information
#
# Table name: user_sessions
#
#  id               :integer          not null, primary key
#  year             :integer
#  try              :integer          default(1)
#  absences_session :integer
#  grades_session   :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  update_number    :integer
#

require 'spec_helper'

describe UserSession do

  describe 'relations and validations' do
    it { should have_many(:grades) }
    it { should have_many(:exams) }
    it { should have_many(:absences) }
    it { should belong_to(:user) }
  end

  describe '#title' do
    let(:session) { build :user_session}
    subject { session.title }

    context 'when session is empty' do
      it { should eq 'HEI' }
    end

    context 'when session is NOT empty' do
      let(:session) { build :user_session, year: 2}
      it { should eq 'HEI2' }

      context 'when session is NOT a first try' do
        let(:session) { build :user_session, year: 4, try: 2}
        it { should eq 'HEI4-2' }
      end
    end
  end

  describe '#is_main_session?' do
    let(:user)      { create :user }
    let!(:session1) { create :user_session, year: 1, user: user}
    let!(:session2) { create :user_session, year: 2, user: user}


    context 'when session is the main session' do
      subject { session2.is_main_session? }
      it { should be_true }
    end

    context 'when session is NOT the main session' do
      subject { session1.is_main_session? }
      it { should be_false }
    end
  end

end
