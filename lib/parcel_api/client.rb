module ParcelApi
  class Client

    attr_accessor :client_id,
      :client_secret,
      :username,
      :password,
      :address,
      :auth_address

    def self.connection
      @connection = ParcelApi::Client.new.connection
    end

    def initialize
      @client_id     = client_id     || ENV['CLIENT_ID']
      @client_secret = client_secret || ENV['CLIENT_SECRET']
      @username      = username      || ENV['USERNAME']
      @password      = password      || ENV['PASSWORD']
      @address       = address       || 'https://api.nzpost.co.nz'
      @auth_address  = auth_address  || 'https://oauth.nzpost.co.nz/as/token.oauth2'
    end

    def connection
      Faraday.new(url: @address) do |conn|
        conn.authorization 'Bearer', token
        conn.headers['client_id'] = @client_id
        conn.request  :json
        conn.response :json,  :content_type => /\bjson$/
        conn.use      FaradayMiddleware::RaiseHttpException
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

        auth_api = Faraday.new do |conn|
          conn.request  :url_encoded
          conn.response :json
          conn.use      FaradayMiddleware::RaiseHttpException
          conn.adapter  Faraday.default_adapter
        end
        response = auth_api.post @auth_address, params
        response.body['access_token']
      end
    end

  end
end
