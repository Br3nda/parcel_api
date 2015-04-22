require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module ParcelApi
  class Address

    AUTOCOMPLETE_URL  = '/v2/addresses'

    def initialize(params={})
      address = params.fetch(:address, 'http://addressing-nzpg.au.cloudhub.io')
      @connection = ParcelApi::Client.create(client_id: params[:client_id], client_secret: params[:client_secret], username: params[:username], password: params[:password], address: address)
    end

    def search(query,count=10)
      collectedAddresses = []
      count = 10 if count > 10
      options = {
        q: query,
        count: count
      }
      response = @connection.get AUTOCOMPLETE_URL, options
      dataResults = response.body['addresses']
      dataResults.each do |address|
        data = OpenStruct.new(address)
        collectedAddresses << data
      end
      return collectedAddresses 
    end

    def address_detail(address_id)
      details_url = File.join(AUTOCOMPLETE_URL, address_id.to_s)
      response = @connection.get details_url
      complete_address_details = response.body['address']
      return OpenStruct.new(complete_address_details)
    end
    end

  end
end