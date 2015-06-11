require 'faraday'
require 'faraday_middleware'

module ParcelApi
  class Client

    attr_accessor :client_id,
      :client_secret,
      :username,
      :password,
      :address

    def initialize
      @client_id = client_id || ENV['CLIENT_ID']
      @client_secret = client_secret || ENV['CLIENT_SECRET']
      @username = username || ENV['USERNAME']
      @password = password || ENV['PASSWORD']
    end

    def create
      Faraday.new(url: address) do |conn|
        conn.authorization :bearer, token
        conn.headers['client_id'] = @client_id
        conn.request  :json
        conn.response :json
        conn.use      ParcelApi::ResponseError
        conn.adapter  Faraday.default_adapter
      end
    end

    private

    def token
      @token ||= begin
        params = {
          client_id:     @client_id,
          client_secret: @client_secret,
          username:      @username,
          password:      @password,
          grant_type:    'password',
        }

        connection = Faraday.new do |conn|
          conn.request  :url_encoded
          conn.response :json
          conn.use      ParcelApi::ResponseError
          conn.adapter  Faraday.default_adapter
        end
        response = connection.post 'https://oauth.nzpost.co.nz/as/token.oauth2', params
        response.body['access_token']
      end
    end

  end
end
