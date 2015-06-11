module ParcelApi

  # This module provides API requests to label parcels, get existing label details
  # and download labels.

  class Label

    attr_accessor :connection

    LABEL_URL = '/ParcelLabel/2.0/labels'

    # Creates a new ParcelApi::Label instance.

    def initialize
      @connection = connection || ParcelApi::Client.connection
    end

    # Create a label with the specified options
    # @param label_options [Hash]
    # @return Single or array of label objects

    def create(label_options)
      domestic_url = File.join(LABEL_URL, 'domestic')
      response = @connection.post domestic_url, label_options
      labels = response.body['labels'].map {|label| OpenStruct.new(label)}
      labels.first if labels.count == 1
    end

    # Get label details
    # @param label_id [String]
    # @return Object of label details

    def details(label_id)
      details_url = File.join(LABEL_URL, "#{label_id}.json")
      response = @connection.get details_url
      details = response.body.tap {|d| d.delete('success')}
      OpenStruct.new(details)
    end

    # Download label
    # @param label_id [String]
    # @return Object of label

    def download(label_id)
      download_url = File.join(LABEL_URL, "#{label_id}.pdf")
      response = @connection.get download_url
      StringIO.new(response.body)
    end

  end

end
