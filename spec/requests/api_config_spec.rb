# encoding: utf-8

require 'spec_helper'

describe 'API client updates its config' do

  before :each do
    Feature.where(key: 'maintenance', enabled: false).first_or_create
  end

  it 'returns the configuration when the maintenance is off' do
    get '/api/v1/config.json'

    expect(response.body).to eq '{"config":{"url":"https://hei-connect-web.herokuapp.com/","android_minimum_version":10001}}'
  end

  it 'returns an error when the maintenance is on' do
    Feature.enable_maintenance
    get '/api/v1/config.json'

    expect(response.response_code).to eq 503
    expect(response.body).to eq '{"error":{"code":10,"message":"L\'application est en maintenance"}}'
  end
end