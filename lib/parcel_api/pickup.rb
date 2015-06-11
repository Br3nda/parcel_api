module ParcelApi

  # The ParcelPickUp API that notifies PACE or CourierPost to come and pick up your parcel.
  # The integrator provides the pick up location in the form of a site id or an address to create the pick up record.

  class Pickup

    attr_accessor :connection

    PARCELPICKUP_URL = '/parcelpickup/2.0/'

    # Creates a new ParcelApi::Pickup instance.

    def initialize
      @connection = connection || ParcelApi::Client.connection
    end

    # Create a new parcel booking
    # @param pickup_options [Hash]
    # @return Object of pickup details

    def create(pickup_options)
      response = @connection.post PARCELPICKUP_URL, pickup_options
      RecursiveOpenStruct.new(response.body, recurse_over_arrays: true)
    end

  end

end
