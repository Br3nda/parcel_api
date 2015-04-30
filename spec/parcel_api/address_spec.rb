require 'spec_helper'
require 'parcel_api/address'

describe ParcelApi::Address do

  before do
    @client = ParcelApi::Address.new(client_id: '456465465465asd', client_secret: 'asd45465', username: 'username', password: 'password')
  end

  context 'Search', vcr: { cassette_name: 'domestic_addresses' } do

    it 'should returns a list of domestic addresses' do
      response = @client.search('151vic',10)
      expect(response).to_not be_empty
    end

    it 'should returns empty set for address fragment less than 4 characters' do
      response = @client.search('151',10)
      expect(response).to be_empty
    end

    it 'should returns a list of domestic addresses with default count' do
      response = @client.search('151vic')
      expect(response).to_not be_empty
    end

  end

  context 'Search', vcr: { cassette_name: 'match_domestic_addresses_count' } do

    it 'should retreive domestic addresses with 5 matches returned' do
      response = @client.search('151vic',5)
      expect(response.count).to eq 5
      expect(response).to_not be_empty
    end

  end

  context 'Address Detail', vcr: { cassette_name: 'domestic_address_detail' } do

    it 'should return complete address detail for specific address' do
      response = @client.address_detail('325595')
      expect(response).to_not be_nil
    end

  end

end