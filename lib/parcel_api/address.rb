require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module ParcelApi
  class Address

    AUTOCOMPLETE_URL  = '/v2/addresses'

    def search(query,count)
      collectedAddresses = []
      options = {
        :q => query,
        :count => count
      }
      @connection = ParcelApi::Client.create
      response = @connection.get AUTOCOMPLETE_URL, options
      dataResults = response.body['addresses']
      dataResults.each do |address|
        complete_address_details = address_detail(address)
        data = OpenStruct.new(complete_address_details)
        collectedAddresses << data
      end
      return collectedAddresses 
    end

    def address_detail(address)
      details_url = File.join(AUTOCOMPLETE_URL, address['address_id'].to_s)
      response = @connection.get details_url
      complete_address_details = response.body['address']
      return complete_address_details
    end

  end
end