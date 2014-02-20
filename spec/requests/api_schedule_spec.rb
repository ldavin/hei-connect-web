# encoding: utf-8

require 'spec_helper'

describe 'API User fetches its schedule' do

  let(:api_token) { 'the_secret_token' }
  let!(:user) { create :user, api_token: api_token }

  describe 'when there are NO classes' do
    it 'returns an empty list for today' do
      parameters = {token: api_token}
      get 'api/v1/schedule/today.json', parameters

      expect(response.response_code).to eq 200
      expect(response.body).to eq "{\"courses\":[],\"last_update\":{\"state\":\"#{user.schedule_update.state}\",\"updated_at\":#{user.schedule_update.updated_at.to_json}}}"
    end

    it 'returns an empty list for tomorrow' do
      parameters = {token: api_token}
      get 'api/v1/schedule/tomorrow.json', parameters

      expect(response.response_code).to eq 200
      expect(response.body).to eq "{\"courses\":[],\"last_update\":{\"state\":\"#{user.schedule_update.state}\",\"updated_at\":#{user.schedule_update.updated_at.to_json}}}"
    end
  end

  describe 'when there are classes' do
    let(:section1) { create :section, name: 'Chimie' }
    let(:section2) { create :section, name: 'Physique' }
    let(:rooms1) { [create(:room, name: 'AC602')] }
    let(:rooms2) { [create(:room, name: 'B216')] }
    let(:kind1) { 'Cours' }
    let(:kind2) { 'TD' }
    let(:course1) { create :course, kind: kind1, section: section1, rooms: rooms1, length: 20, date: DateTime.now }
    let(:course2) { create :course, kind: kind2, section: section2, rooms: rooms2, length: 20, date: DateTime.now + 1.day }

    before {
      user.courses << [course1, course2]
    }

    it 'returns the courses for today' do
      parameters = {token: api_token}
      get 'api/v1/schedule/today.json', parameters

      expect(response.response_code).to eq 200
      expect(response.body).to eq "{\"courses\":[{\"id\":#{course1.id},\"kind\":\"#{course1.kind}\",\"name\":\"#{course1.short_name}\",\"place\":\"#{course1.place}\",\"date\":#{course1.date.to_json},\"end_date\":#{course1.end_date.to_json}}],\"last_update\":{\"state\":\"#{user.schedule_update.state}\",\"updated_at\":#{user.schedule_update.updated_at.to_json}}}"
    end

    it 'returns an empty list for tomorrow' do
      parameters = {token: api_token}
      get 'api/v1/schedule/tomorrow.json', parameters

      expect(response.response_code).to eq 200
      expect(response.body).to eq "{\"courses\":[{\"id\":#{course2.id},\"kind\":\"#{course2.kind}\",\"name\":\"#{course2.short_name}\",\"place\":\"#{course2.place}\",\"date\":#{course2.date.to_json},\"end_date\":#{course2.end_date.to_json}}],\"last_update\":{\"state\":\"#{user.schedule_update.state}\",\"updated_at\":#{user.schedule_update.updated_at.to_json}}}"
    end
  end

end