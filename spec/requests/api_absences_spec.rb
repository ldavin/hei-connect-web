# encoding: utf-8

require 'spec_helper'

describe 'API User fetches its absences' do

  let(:api_token) { 'the_secret_token' }
  let!(:user) { create :user, api_token: api_token }
  let!(:user_session) { create :user_session, user: user }

  let(:section) { create :section, name: 'Chimie' }
  let(:absence) { create :absence, date: DateTime.now, length: 90, section: section }

  describe 'when user has NO absences' do
    it 'returns an empty list' do
      parameters = {token: api_token}
      get 'api/v1/absences.json', parameters

      expect(response.response_code).to eq 200
      expect(response.body).to eq "{\"absences\":[],\"last_update\":{\"state\":\"#{user.absences_update(user_session.absences_session).state}\",\"updated_at\":#{user.absences_update(user_session.absences_session).updated_at.to_json}}}"
    end
  end

  describe 'when user HAS absences' do
    before {
      user_session.absences << absence
    }

    it 'returns the absences' do
      parameters = {token: api_token}
      get 'api/v1/absences.json', parameters

      expect(response.response_code).to eq 200
      expect(response.body).to eq "{\"absences\":[{\"id\":1,\"section_name\":\"Chimie\",\"date\":#{absence.date.to_json},\"length\":5400}],\"last_update\":{\"state\":\"#{user.absences_update(user_session.absences_session).state}\",\"updated_at\":#{user.absences_update(user_session.absences_session).updated_at.to_json}}}"
    end
  end

end