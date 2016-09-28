require 'spec_helper'
require 'support/parcel_api'

describe ParcelApi::Track, :vcr do
  let(:tracking) { ParcelApi::Track.new }

  context 'Parcel Track Information' do

    it 'should return complete tracking information for specific tracking reference' do
      response = tracking.details('8144152543878001AKL002PN')
      expect(response).to_not be_nil
    end

  end
end
