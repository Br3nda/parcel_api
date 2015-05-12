require 'spec_helper'
require 'parcel_api'

describe ParcelApi::ParcelTrack do

  before do
    @client = ParcelApi::ParcelTrack.new(client_id: '456465465465asd', client_secret: 'asd45465', username: 'username', password: 'password')
  end

  context 'Parcel Track Information', vcr: { cassette_name: 'parcel_track_information' } do

    it 'should return complete tracking information for specific tracking reference' do
      response = @client.tracking_detail('2420059066827301HLZ001MN')
      expect(response).to_not be_nil
    end

  end

end