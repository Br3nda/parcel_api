require 'parcel_api'

# configure the client
client = ParcelApi::Client.new.tap do |config|
  config.client_id     = ENV['CLIENT_ID']
  config.client_secret = ENV['CLIENT_SECRET']
  config.username      = ENV['USERNAME']
  config.password      = ENV['PASSWORD']
end

# Address examples

query = '151 vic'
address = ParcelApi::Address.new
# search for the query, 3 results
results = address.search(query, 3)
puts "Address Search: #{query}"
puts "Results:"
# dump the results out
puts results.map {|r| r.full_address}

# get details for the first result
puts 'First Address Details:'
details = address.details(results.first.address_id)

# dump the detail parts out
details.to_h.each {|k, v| puts "#{k}: #{v}"}

intl_query = '38 Lap'
# search for the query, defult number of results
intl_results = address.international_search(intl_query)
puts "International Address Search: #{query}"
puts "Results:"
puts intl_results.map {|r| r.full_address}

# get details for the first result
puts 'First International Address Details:'
intl_details = address.international_details(intl_results.first.address_id)

# dump the detail parts out
intl_details.to_h.each {|k, v| puts "#{k}: #{v}"}

# Tracking Example

tracking = ParcelApi::Track.new
results = tracking.details('1818120002213401AKL003HN')

# example tracking output
last_event = results.tracking_events.last
puts results.carrier
puts results.service
puts last_event.event_datetime.to_s + ' ' + last_event.event_description
