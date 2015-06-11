# require 'spec_helper'
# require 'parcel_api'
#
# describe ParcelApi::Address do
#
#   before do
#     @client = ParcelApi::Address.new(client_id: '456465465465asd', client_secret: 'asd45465',
#                                       username: 'username', password: 'password')
#   end
#
#   context 'Domestic Address Search', vcr: { cassette_name: 'domestic_addresses' } do
#
#     it 'should returns a list of domestic addresses' do
#       response = @client.search('151vic',10)
#       expect(response).to_not be_empty
#     end
#
#     it 'should returns empty set for address fragment less than 4 characters' do
#       response = @client.search('151',10)
#       expect(response).to be_empty
#     end
#
#     it 'should returns a list of domestic addresses with default count' do
#       response = @client.search('151vic')
#       expect(response).to_not be_empty
#     end
#
#   end
#
#   context 'Retrieve 5 Addresses', vcr: { cassette_name: 'domestic_addresses_count' } do
#
#     it 'should retreive domestic addresses with 5 matches returned' do
#       response = @client.search('151vic',5)
#       expect(response.count).to eq 5
#       expect(response).to_not be_empty
#     end
#
#   end
#
#   context 'Domestic Address Detail', vcr: { cassette_name: 'domestic_address_detail' } do
#
#     it 'should return complete address detail for specific address' do
#       response = @client.address_detail('325595')
#       expect(response).to_not be_nil
#     end
#
#   end
#
#   context 'International Address Search', vcr: { cassette_name: 'international_addresses' } do
#
#     it 'should returns a list of international addresses' do
#       response = @client.international_search('3800 La Pasada',5)
#       expect(response).to_not be_empty
#     end
#
#     it 'should returns empty set for address fragment less than 4 characters' do
#       response = @client.international_search('151',5)
#       expect(response).to be_empty
#     end
#
#   end
#
#   context 'International Address Detail', vcr: { cassette_name: 'international_address_detail' } do
#
#     it 'should return complete address detail for specific international address' do
#       response = @client.details('EjAzODAwIExhIFBhc2FkYSBBdmUsIExhcyBWZWdhcywgTlYsIFVuaXRlZCBTdGF0ZXM')
#       expect(response).to_not be_nil
#     end
#
#   end
#
#   context 'Retrieve 3 Addresses', vcr: { cassette_name: 'international_addresses_count' } do
#
#     it 'should retreive international addresses with 3 matches returned' do
#       response = @client.international_search('3800 La Pasada',3)
#       expect(response.count).to eq 3
#       expect(response).to_not be_empty
#     end
#
#   end
# end
