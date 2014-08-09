# encoding: utf-8

require 'spec_helper'

describe 'API User fetches its grades' do

  let(:api_token) { 'the_secret_token' }
  let!(:user) { create :user, api_token: api_token }
  let!(:user_session) { create :user_session, user: user }

  let(:section) { create :section, name: 'Chimie' }
  let(:exam) { create :exam, name: 'The exam', date: Date.yesterday, average: 0, grades_count: 0, section: section }
  let!(:grade) { create :grade, unknown: false, mark: 11.5, exam: exam }

  describe 'when user has NO grades' do
    it 'returns an empty list' do
      parameters = {token: api_token}
      get 'api/v1/grades.json', parameters

      expect(response.response_code).to eq 200
      expect(response.body).to eq "{\"grades\":[],\"last_update\":{\"state\":\"#{user.grades_update(user_session.grades_session).state}\",\"updated_at\":#{user.grades_update(user_session.grades_session).updated_at.to_json}}}"
    end
  end

  describe 'when user HAS grades' do
    before {
      user_session.grades << grade
    }

    it 'returns the grades' do
      parameters = {token: api_token}
      get 'api/v1/grades.json', parameters

      expect(response.response_code).to eq 200
      expect(response.body).to eq "{\"grades\":[{\"id\":1,\"section_name\":\"Chimie\",\"exam_name\":\"The exam\",\"date\":\"2014-08-08\",\"unknown\":false,\"mark\":11.5,\"average\":0.0,\"average_count\":0}],\"last_update\":{\"state\":\"#{user.grades_update(user_session.grades_session).state}\",\"updated_at\":#{user.grades_update(user_session.grades_session).updated_at.to_json}}}"
    end
  end

end