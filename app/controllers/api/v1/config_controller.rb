class Api::V1::ConfigController < Api::ApiController

  def index
    @config = OpenStruct.new
    @config.url = 'https://hei-connect-web.herokuapp.com/'
    @config.android_minimum_version = 10001
  end
end
