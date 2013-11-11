require 'spec_helper'

describe User do

  describe 'relations and validations' do
    it { should have_many(:course_users) }
    it { should have_many(:courses) }
    it { should have_many(:updates) }
    it { should have_many(:sessions) }
    it { should have_many(:grades) }
    it { should have_many(:absences) }

    it { should validate_presence_of(:ecampus_id) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_uniqueness_of(:ecampus_id) }
  end

  describe '#authenticate' do
    let!(:user) { create :user, password: 'kikoo' }
    subject { user.authenticate password }

    context 'when password is right' do
      let(:password) { 'kikoo' }
      it { should eq user }
    end

    context 'when password is NOT right' do
      let(:password) { 'lol' }
      it { should be_false }
    end

  end

  describe '#to_s' do
    let(:name) { %w(un etudiant lambda).sample }
    let(:user) { build :user, ecampus_id: name }
    subject { user.to_s }
    it { should eq name }
  end

  describe '#main_session' do
    let(:user) { create :user }
    subject { user.main_session }

    context 'when NO sessions' do
      it { should be_nil }
    end

    context 'when regular sessions' do
      let!(:session1) { create :user_session, year: 1, user: user}
      let!(:session2) { create :user_session, year: 2, user: user}
      let!(:session3) { create :user_session, year: 3, user: user}

      it { should eq session3 }

      context 'when a second try' do
        let!(:session4) { create :user_session, year: 3, try: 2, user: user}
        it { should eq session4 }
      end
    end
  end


  describe '#set_ics_key' do
    let(:user) { build :user }
    subject { user }
    before { user.save! }
    its(:ics_key) { should_not be_blank }
  end
end