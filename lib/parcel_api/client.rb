require 'faraday'
require 'faraday_middleware'

module ParcelApi
  class Client
    def self.create(options={})
      if !options[:client_id] || !options[:client_secret] || !options[:username] || !options[:password]
        raise ParcelApi::Error, "Missing required client identifier."
      end
      token = ParcelApi::Client.get_token(client_id: options[:client_id], client_secret: options[:client_secret],
                username: options[:username], password: options[:password])

      connection = Faraday.new(url: options[:address]) do |conn|
        conn.authorization :Bearer, token
        conn.request :json
        conn.response :json
        conn.use ParcelApi::ResponseError      # raise exceptions on 40x, 50x responses
        conn.adapter Faraday.default_adapter
      end
    end

    def self.get_token(options={})
      connection = Faraday.new({ ssl: { verify: false } }) do |conn|
        conn.request :url_encoded
        conn.response :json
        conn.use ParcelApi::ResponseError
        conn.adapter Faraday.default_adapter
      end
      params = {'client_id' => options[:client_id],
                'client_secret' => options[:client_secret],
                'username' => options[:username],
                'password' => options[:password],
                'grant_type' => 'password'
               }
      response = connection.post 'https://oauth.nzpost.co.nz/as/token.oauth2', params
      return response.body['access_token']
    end
  end
end