require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module ParcelApi

  #This module provides API requests to Search Domestic(NZ) Address, Get Specific Domestic Address Detail,
  #Search International Address and Get Specifc International Address Detail.

  class Address

    AUTOCOMPLETE_URL = '/ParcelAddress/2.0/domestic/addresses'
    INTERNATIONAL_URL = '/ParcelAddress/2.0/international/addresses'

    # Creates a new ParcelApi::Address instance.
    # @param [Hash] params pass auth credentials(client_id, client_secret, username, password)
    def initialize(params={})
      address = params.fetch(:address, 'https://api.nzpost.co.nz')
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

    # Search for International Address with a query.
    # @param [String] query the query to search for
    # @param [Integer] count the number of search results 
    # @return [Array] return array of international addresses

    def international_search(query, count=5)
      collectedAddresses = []
      count = 5 if count > 5
      unless(query.length < 4)
        options = {
          q: query,
          count: count
        }
        response = @connection.get INTERNATIONAL_URL, options
        dataResults = response.body['addresses'] unless response.body.nil?
        dataResults.each do |address|
          data = OpenStruct.new(address)
          collectedAddresses << data
        end unless dataResults.nil? or dataResults.empty?
      end
      return collectedAddresses
    end

    # Return complete address detail for specific address.
    # @param address_id [Srting]
    # @return Object Of complete international address detail

    def details(address_id)
      details_url = File.join(INTERNATIONAL_URL, address_id.to_s)
      response = @connection.get details_url
      address_components = response.body['result']['address_components']
      street_number = address_component(:street_number, 'short_name', address_components)
      street = address_component(:route, 'long_name', address_components)
      city = address_component(:locality, 'long_name', address_components)
      region = address_component(:administrative_area_level_1, 'long_name', address_components)
      postal_code = address_component(:postal_code, 'long_name', address_components)
      country = address_component(:country, 'long_name', address_components)
      return OpenStruct.new( street_number: street_number, street: street, city: city,
                            region: region, postal_code: postal_code, country: country)
    end

    def address_component(address_component_type, address_component_length, address_components)
      if component = address_components_of_type(address_component_type, address_components)
        component.first[address_component_length] unless component.first.nil?
      end
    end

    def address_components_of_type(type, address_components)
      address_components.select{ |c| c['types'].include?(type.to_s) } unless address_components.nil?
    end

  end
end