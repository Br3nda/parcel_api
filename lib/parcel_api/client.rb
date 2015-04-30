require 'faraday'
require 'faraday_middleware'
require 'parcel_api/error'

module ParcelApi
  class Client
    def self.create(options={})
      if !options[:client_id] || !options[:client_secret] || !options[:username] || !options[:password]
        raise ParcelApi::Error, "Missing required client identifier."
      end
      connection = Faraday.new(url: options[:address]) do |conn|
        conn.request :oauth2,
        client_id: options[:client_id],
        client_secret: options[:client_secret],
        username: options[:username],
        password: options[:password],
        grant_type: 'password'
        conn.request :json
        conn.response :json
        conn.use ParcelApi::ResponseError      # raise exceptions on 40x, 50x responses
        conn.adapter Faraday.default_adapter
      end
    end
  end
end