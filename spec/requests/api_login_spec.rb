# encoding: utf-8

require 'spec_helper'

describe 'API User signs in' do

  before :each do
    Feature.where(key: 'user_login', enabled: true, error_message: 'Le login est down ma poule!').first_or_create
  end

  let(:id) { 'h01234' }
  let(:unknown_id) { 'h98765' }
  let(:valid_password) { 'password' }
  let(:invalid_password) { 'kikoolol' }
  let!(:user) { create :user, ecampus_id: id, password: valid_password, api_token: 'the-token' }

  it 'returns the api key for a valid user' do
    parameters = {user: {ecampus_id: id, password: valid_password }}
    post 'api/v1/login.json', parameters

    expect(response.body).to eq "{\"user\":{\"ecampus_id\":\"#{id}\",\"api_token\":\"#{user.api_token}\"}}"
  end

  it 'returns an error for a valid user with an invalid password ' do
    parameters = {user: {ecampus_id: id, password: invalid_password }}
    post 'api/v1/login.json', parameters

    expect(response.response_code).to eq 403
    expect(response.body).to eq '{"error":{"code":403.1,"message":"Login/password incorrect"}}'
  end

  it 'returns an error for an unknown user' do
    parameters = {user: {ecampus_id: unknown_id, password: valid_password }}
    post 'api/v1/login.json', parameters

    expect(response.response_code).to eq 403
    expect(response.body).to eq '{"error":{"code":403.2,"message":"Compte inconnu, inscris toi sur hei-connect.eu"}}'
  end

  it 'returns an error when user login is disabled' do
    Feature.disable_user_login
    parameters = {user: {ecampus_id: id, password: valid_password }}
    post 'api/v1/login.json', parameters

    expect(response.response_code).to eq 503
    expect(response.body).to eq "{\"error\":{\"code\":503,\"message\":\"#{Feature.user_login_error_message}\"}}"
  end

end