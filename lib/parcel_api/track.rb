module ParcelApi

  # This module provides API requests to track the parcels and
  # return tracking information for a specific tracking reference.

  class Track

    attr_accessor :connection

    PARCELTRACK_URL = '/ParcelTrack/2.0/parcels'

    # Creates a new ParcelApi::Track instance.

    def initialize
      @connection = connection || ParcelApi::Client.connection
    end

    # Return details for a specific tracking reference.
    # @param tracking_reference [String]
    # @return Object of tracking details

    def details(tracking_reference)
      details_url = File.join(PARCELTRACK_URL, tracking_reference.to_s)
      response = @connection.get details_url
      events = response.body.tap do |d|
        d.delete('success')
        d['tracking_events'].map {|e| e['event_datetime'] = Time.parse(e['event_datetime'])}
        d['tracking_events'].sort_by! {|k| k['event_datetime'].to_i}
      end
      RecursiveOpenStruct.new(events, recurse_over_arrays: true)
    end

  end

end
