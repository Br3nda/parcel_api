require 'faraday'
require 'faraday_middleware'

module ParcelApi
  class Client
    def self.create(options = {})
      connection = Faraday.new do |conn|
        conn.request :oauth2
        conn.request :json
        conn.response :json
        conn.adapter Faraday.default_adapter
      end
    end
  end
end