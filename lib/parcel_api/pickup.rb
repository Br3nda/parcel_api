module ParcelApi

  # The ParcelPickUp API that notifies PACE or CourierPost to come and pick up your parcel.
  # The integrator provides the pick up location in the form of a site id or an address to create the pick up record.

  class Pickup
    PARCELPICKUP_URL = '/ParcelPickUp/3.0/bookings'

    # Creates a new ParcelApi::Pickup instance.

    def initialize(connection=nil)
      @connection ||= connection || ParcelApi::Client.connection
    end

    # Create a new parcel booking
    # @param pickup_options [Hash]
    # @return Object of pickup details

    def create(pickup_options)
      response = @connection.post PARCELPICKUP_URL, body: pickup_options.to_json, headers: { 'Content-Type' => 'application/json' }
      RecursiveOpenStruct.new(response.parsed, recurse_over_arrays: true)
    end

  end

end
