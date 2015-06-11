require 'spec_helper'
require 'support/parcel_api'

describe ParcelApi::Track do

  context 'Parcel Track Information', :vcr do
    it 'should return complete tracking information for specific tracking reference' do
      tracking = ParcelApi::Track.new
      response = tracking.details('2420059066827301HLZ001MN')
      expect(response).to_not be_nil
    end

  end

end
