require 'faraday'
require 'faraday_middleware'

module ParcelApi
  class Client
    def self.create(options = {})
      connection = Faraday.new(url: 'http://addressinguat-nzpg.au.cloudhub.io') do |conn|
        conn.request :oauth2,
        client_id: ENV['CLIENT_ID'] ,
        client_secret: ENV['CLIENT_SECRET'],
        username: ENV['USER_NAME'],
        password: ENV['PASSWORD'],
        grant_type: 'password'
        conn.request :json
        conn.response :json
        conn.adapter Faraday.default_adapter
      end
    end
  end
end