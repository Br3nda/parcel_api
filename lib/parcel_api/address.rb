require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module ParcelApi

  #This module provides API requests to Search Domestic(NZ) Address and Get Specific Address Detail.

  class Address

    AUTOCOMPLETE_URL  = '/v2/addresses'

    # Creates a new ParcelApi::Address instance.
    # @param [Hash] params pass auth credentials(client_id, client_secret, username, password)
    def initialize(params={})
      address = params.fetch(:address, 'http://addressing-nzpg.au.cloudhub.io')
      @connection = ParcelApi::Client.create(client_id: params[:client_id],
                    client_secret: params[:client_secret], username: params[:username],
                    password: params[:password], address: address)
    end

    # Search for NZ domestic Address with a query.
    # @param [String] query the query to search for
    # @param [Integer] count the number of search results 
    # @return [Array] return array of addresses

    def search(query,count=10)
      collectedAddresses = []
      count = 10 if count > 10
      unless(query.length < 4)
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
      end
      return collectedAddresses 
    end

    # Return complete address detail for specific address.
    # @param address_id [Srting]
    # @return Object Of complete address detail

    def address_detail(address_id)
      details_url = File.join(AUTOCOMPLETE_URL, address_id.to_s)
      response = @connection.get details_url
      complete_address_details = response.body['address']
      return OpenStruct.new(complete_address_details)
    end

  end
end