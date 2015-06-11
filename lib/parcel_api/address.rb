module ParcelApi

  # This module provides API requests to Search Domestic(NZ) Addresses, Get Specific Domestic Address Detail,
  # Search International Addresses and Get Specifc International Address Detail.

  class Address
    DOMESTIC_URL = '/ParcelAddress/2.0/domestic/addresses'
    INTERNATIONAL_URL = '/ParcelAddress/2.0/international/addresses'

    # Creates a new ParcelApi::Address instance.

    def initialize(connection=nil)
      @connection ||= connection || ParcelApi::Client.connection
    end

    # Search for Domestic (NZ) Address
    # @param [String] query the query to search for
    # @param [Integer] count the number of search results
    # @return [Array] return array of addresses

    def search(query, count=10)
      return [] if query.length < 4

      response = @connection.get DOMESTIC_URL, { q: query, count: count }
      addresses = response.body['addresses'].each do |a|
        a['address_id'] = Integer(a['address_id'])
        a['dpid'] = Integer(a['dpid'])
      end
      addresses.map {|address| OpenStruct.new(address)}
    end

    # Return address details for an address id
    # @param address_id [Srting]
    # @return Object Of complete address detail

    def details(address_id)
      details_url = File.join(DOMESTIC_URL, address_id.to_s)
      response = @connection.get details_url
      OpenStruct.new(response.body['address'])
    end

    # Search for an International Address
    # @param [String] query the query to search for
    # @param [Integer] count the number of search results
    # @return [Array] return array of international addresses

    def international_search(query, count=5, country_code=nil)
      return [] if query.length < 4

      response = @connection.get INTERNATIONAL_URL, { q: query, count: count, country_code: country_code }
      response.body['addresses'].map {|address| OpenStruct.new(address)}
    end

    # Return international address details for a specific international address id
    # @param address_id [String]
    # @return Object of international address detail

    def international_details(address_id)
      details_url = File.join(INTERNATIONAL_URL, address_id.to_s)
      response = @connection.get details_url
      RecursiveOpenStruct.new(response.body['result'], recurse_over_arrays: true)
    end

  end
end
