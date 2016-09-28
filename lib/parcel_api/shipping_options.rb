module ParcelApi

  # Returns the shipping options and rates available depending on customer,
  # pick up and destination addresses and parcel dimensions and weight.
  # Both domestic and international.

  class ShippingOptions
    DOMESTIC_URL = '/ShippingOptions/2.0/domestic'
    INTERNATIONAL_URL = '/ShippingOptions/2.0/international'

    # Creates a new ParcelApi::ShippingOptions instance.

    def initialize(connection=nil)
      @connection ||= connection || ParcelApi::Client.connection
    end

    # Search for Domestic (NZ) Shipping Options
    # @param parcel_params [Hash] parcel parameters
    # @return [Array] return array of shipping options

    def get_domestic(parcel_params)
      response = @connection.get DOMESTIC_URL, params: parcel_params
      options = response.parsed.tap do |so|
        so.delete('success')
        so.delete('message_id')
      end
      RecursiveOpenStruct.new(options, recurse_over_arrays: true)
    end

    # Search for International Shipping Options
    # @param parcel_params [Hash] parcel parameters
    # @return [Array] return array of shipping options

    def get_international(parcel_params)
      response = @connection.get INTERNATIONAL_URL, params: parcel_params
      options = response.parsed.tap do |so|
        so.delete('success')
        so.delete('message_id')
      end
      RecursiveOpenStruct.new(options, recurse_over_arrays: true)
    end

  end
end
