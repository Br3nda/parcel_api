require 'spec_helper'
require 'support/parcel_api'

describe ParcelApi::Address, :vcr do
  let(:address) { ParcelApi::Address.new }

  context 'Domestic Address Search' do
    it 'should returns a list of domestic addresses' do
      response = address.search('151vic', 10)
      expect(response).to_not be_empty
    end

    it 'should returns empty set for address fragment less than 4 characters' do
      response = address.search('151', 10)
      expect(response).to be_empty
    end

    it 'should returns a list of domestic addresses with default count' do
      response = address.search('151 vic')
      expect(response).to_not be_empty
    end
  end

  context 'Retrieve 5 Addresses' do
    it 'should retreive domestic addresses with 5 matches returned' do
      response = address.search('151 vic', 5)
      expect(response.count).to eq 5
      expect(response).to_not be_empty
    end

  end

  context 'Domestic Address Detail' do
    it 'should return complete address detail for specific address' do
      response = address.details('325595')
      expect(response).to_not be_nil
    end
  end

  context 'International Address Search' do
    it 'should returns a list of international addresses' do
      response = address.international_search('3800 La Pasada', 5)
      expect(response).to_not be_empty
    end

    it 'should returns empty set for address fragment less than 4 characters' do
      response = address.international_search('151', 5)
      expect(response).to be_empty
    end
  end

  context 'International Address Detail' do
    it 'should return complete address detail for specific international address' do
      response = address.international_details('EjAzODAwIExhIFBhc2FkYSBBdmUsIExhcyBWZWdhcywgTlYsIFVuaXRlZCBTdGF0ZXM')
      expect(response).to_not be_nil
    end
  end

  context 'Retrieve 3 Addresses' do
    it 'should retreive international addresses with 3 matches returned' do
      response = address.international_search('3800 La Pasada', 3)
      expect(response.count).to eq 3
      expect(response).to_not be_empty
    end
  end
end
