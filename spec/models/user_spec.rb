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

end