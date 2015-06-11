require 'parcel_api'

# configure the client
client = ParcelApi::Client.new.tap do |config|
  config.client_id     = ENV['CLIENT_ID']
  config.client_secret = ENV['CLIENT_SECRET']
  config.username      = ENV['USERNAME']
  config.password      = ENV['PASSWORD']
end

# address = ParcelApi::Address.new
#
# #Search Domestic Address for NZ
#
# address.search('151 vic', 10)
#
# #Use address_detail method to retrieve a complete set of the address detail. In this method you have to pass the address_id
#
# address.address_detail('325595')
