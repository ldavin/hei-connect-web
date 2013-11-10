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
  end

end