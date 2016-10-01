module ParcelApi

  # Creates a PCD (collection point) subscription with provided delivery email address
  # and tracking reference. Customers will receive an email when the parcel reaches the
  # collection point and then subsequent reminders.

  class Notification
    PARCELNOTIFICATION_URL = '/parcelnotifications/v1/subscription/pcd'

    # Creates a new ParcelApi::Notification instance.

    def initialize(connection=nil)
      @connection ||= connection || ParcelApi::Client.connection
    end

    # Create a new parcel notification
    # @param notification_options [Hash]
    # @return Object of notification details

    def create(notification_options)
      response = @connection.post PARCELNOTIFICATION_URL, body: notification_options.to_json, headers: { 'Content-Type' => 'application/json' }
      RecursiveOpenStruct.new(response.parsed, recurse_over_arrays: true)
    end

  end

end
