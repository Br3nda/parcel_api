require 'faraday'
require 'faraday_middleware'

module ParcelApi
  class Address

    attr_reader :api_key
    attr_reader :options

    AUTOCOMPLETE_URL  = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
    DETAILS_URL       = 'https://maps.googleapis.com/maps/api/place/details/json'

    def search(input)
      collectedAddresses = []
      @api_key = ENV['API_KEY']
      options = {
        :input => input,
        :key => @api_key
      }
      @connection = ParcelApi::Client.create
      response = @connection.get AUTOCOMPLETE_URL, options
      dataResults = response.body['predictions']
      dataResults.each do |address|
        data ={}
        full_address = address_detail(address, @api_key)
        address_id = address['place_id']
        data.merge!(address_id: address_id, full_address: full_address)
        collectedAddresses << data
      end
      return collectedAddresses 
    end

    def address_detail(address, key)
      options = {
        :placeid => address['place_id'],
        :key => key
      }
      response = @connection.get DETAILS_URL, options
      address_components = response.body['result']['address_components']
      street_number = address_component(:street_number, 'short_name', address_components)
      street = address_component(:route, 'long_name', address_components)
      city = address_component(:locality, 'long_name', address_components)
      region = address_component(:administrative_area_level_1, 'long_name', address_components)
      postal_code = address_component(:postal_code, 'long_name', address_components)
      country = address_component(:country, 'long_name', address_components)
      full_address = street_number, street , city , region , postal_code, country
      full_address = full_address.compact.join(',')
      return full_address
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