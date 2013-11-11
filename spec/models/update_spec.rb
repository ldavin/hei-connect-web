# encoding: utf-8

require 'spec_helper'

describe Update do

  describe 'relations' do
    it { should belong_to(:user) }
  end

  describe '#title' do
    let(:update) { build :update }
    subject { update.title }

    context 'when object is user' do
      let(:update) { build :update, object: Update::OBJECT_USER.to_s }
      it { should eq 'Validité du compte' }
    end

    context 'when object is schedule' do
      let(:update) { build :update, object: Update::OBJECT_SCHEDULE.to_s }
      it { should eq 'Emploi du temps' }
    end

    context 'when object is session' do
      let(:update) { build :update, object: Update::OBJECT_SESSIONS.to_s }
      it { should eq 'Années de scolarité' }
    end

    context 'when object is grade' do
      let!(:user)  { create :user }
      let(:update) { build :update, object: Update::OBJECT_GRADES.to_s, user: user }

      context 'when the session is defined' do
        let!(:session) { create :user_session, grades_session: '123', year: 5, user: user }
        let(:update)   { build :update, object: Update::OBJECT_GRADES.to_s + '123', user: user }
        it { should eq 'Notes HEI5' }
      end

      context 'when the session is NOT defined' do
        it { should eq 'Notes' }
      end
    end

    context 'when object is absence' do
      let!(:user)  { create :user }
      let(:update) { build :update, object: Update::OBJECT_ABSENCES.to_s, user: user }

      context 'when the session is defined' do
        let!(:session) { create :user_session, absences_session: '543', year: 3, user: user }
        let(:update)   { build :update, object: Update::OBJECT_ABSENCES.to_s + '543', user: user }
        it { should eq 'Absences HEI3' }
      end

      context 'when the session is NOT defined' do
        it { should eq 'Absences' }
      end
    end

    context 'when object is corrupted' do
      it { should raise_error(Exception) }
    end
  end

  describe '#set_default_state' do
    let(:update) { build :update }
    subject { update }
    before { update.save! }

    context 'when the state is known' do
      let(:update) { build :update, state: Update::STATE_UPDATING.to_s }
      its(:state) { should eq Update::STATE_UPDATING.to_s }
    end

    context 'when the state is NOT known' do
      its(:state) { should eq Update::STATE_UNKNOWN.to_s }
    end
  end
end