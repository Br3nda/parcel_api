require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module ParcelApi

  #This module provides API requests to track the parcels and
  #return tracking information for a specific tracking reference.

  class ParcelTrack

    PARCELTRACK_URL = '/ParcelTrack/2.0/parcels'

    # Creates a new ParcelApi::ParcelTrack instance.
    # @param [Hash] params pass auth credentials(client_id, client_secret, username, password)

    def initialize(params={})
      address = params.fetch(:address, 'https://api.nzpost.co.nz')
      @connection = ParcelApi::Client.create(client_id: params[:client_id],
                    client_secret: params[:client_secret], username: params[:username],
                    password: params[:password], address: address)
    end

    # Return tracking information for a specific tracking reference.
    # @param tracking_reference [Srting]
    # @return Object Of complete tracking information

    def tracking_detail(tracking_reference)
      details_url = File.join(PARCELTRACK_URL, tracking_reference.to_s)
      response = @connection.get details_url
      events = response.body['tracking_events'].to_json
      tracking_events = JSON.parse(events, object_class: OpenStruct).sort_by{|k| k.event_datetime}.reverse
      return OpenStruct.new(tracking_events: tracking_events)
    end

  end

end