require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module ParcelApi
  class Address

    AUTOCOMPLETE_URL  = '/v2/addresses'

    def initialize
      @connection = ParcelApi::Client.create
    end

    def search(query,count=10)
      collectedAddresses = []
      count = 10 if count > 10
      options = {
        :q => query,
        :count => count
      }
      response = @connection.get AUTOCOMPLETE_URL, options
      dataResults = response.body['addresses']
      dataResults.each do |address|
        data = OpenStruct.new(address_id: address['address_id'], full_address: address['full_address'])
        collectedAddresses << data
      end
      return collectedAddresses 
    end

    def address_detail(address_id)
      details_url = File.join(AUTOCOMPLETE_URL, address_id.to_s)
      response = @connection.get details_url
      complete_address_details = response.body['address']
      data = OpenStruct.new(complete_address_details)
      return data
    end

  end
end