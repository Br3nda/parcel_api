module ParcelApi

  # This module provides API requests to label parcels, get existing label details
  # and download labels.

  class Label
    LABEL_URL = '/ParcelLabel/2.0/labels'

    # Creates a new ParcelApi::Label instance.

    def initialize(connection=nil)
      @connection ||= connection || ParcelApi::Client.connection
    end

    # Create a label with the specified options
    # @param label_options [Hash]
    # @return Single or array of label objects

    def create(label_options)
      domestic_url = File.join(LABEL_URL, 'domestic')
      response = @connection.post domestic_url, body: label_options.to_json, headers: { 'Content-Type' => 'application/json' }
      labels = response.parsed['labels'].map {|label| OpenStruct.new(label)}
      labels.first if labels.count == 1
    end

    # Create an international label with the specified options
    # @param label_options [Hash]
    # @return Single or array of label objects

    def international_create(label_options)
      international_url = File.join(LABEL_URL, 'international')
      response = @connection.post international_url, body: label_options.to_json, headers: { 'Content-Type' => 'application/json' }
      labels = response.parsed['labels'].map {|label| OpenStruct.new(label)}
      labels.first if labels.count == 1
    end

    # Get label details
    # @param label_id [String]
    # @return Object of label details

    def details(label_id)
      details_url = File.join(LABEL_URL, "#{label_id}.json")
      response = @connection.get details_url
      details = response.parsed.tap {|d| d.delete('success')}
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
