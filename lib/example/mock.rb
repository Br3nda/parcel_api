module Example
  class Mock
    # ParcelAddress API is a GET API that contains methods that return valid matching domestic or international addresses.
    #You need to configure credentials to make API calls. You can pass configurations options in ParcelApi::Address.new()

    client = ParcelApi::Address.new(client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET'], username: ENV['USER_NAME'], password: ENV['PASSWORD'])

    #Search Domestic Address for NZ

    client.search('151 vic', 10)

    #Use address_detail method to retrieve a complete set of the address detail. In this method you have to pass the address_id 

    client.address_detail('325595')

  end
end