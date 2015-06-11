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


# Labelling example

labeller = ParcelApi::Label.new

# Label options
cp_label_options = {
  "orientation" => "landscape",
  "requests" => [
    {
      "carrier" => "COURIERPOST",
      "sender_details" => {
        "name" => "Glenn Dodd",
        "phone" => "0274123456",
        "email" => "glenn@example.co.nz",
        "reference" => "654334",
      },
      "pickup_address" => {
        "company" => "Glenns Acme Company",
        "city" => "Auckland",
        "floor" => "Floor 2",
        "postcode" => "2102",
        "street" => "25 Buller Crescent",
        "suburb" => "Manurewa",
        "unit_type" => "Flat",
        "unit_value" => "2",
      },
      "receiver_details" => {
        "name" => "Glenn Dodd",
        "phone" => "0274123456",
      },
      "delivery_address" => {
        "company" => "Acme Company",
        "city" => "Auckland",
        "floor" => "Floor 2",
        "postcode" => "2102",
        "street" => "151 Victoria Street",
        "suburb" => "Manurewa",
        "unit_type" => "Flat",
        "unit_value" => "2",
      },
      "return_indicator" => "NORMAL",
      "delivery_instructions" => "Don't feed my dog tonight",
      "service_code" => "CPOLE",
      "add_ons" => [],
      "dimensions" => {
        "weight" => "10",
        "height" => "35",
        "width" => "45",
        "length" => "15",
      }
    }
  ]
}

# create the label
cp = labeller.create(cp_label_options)

# get the label details
details = labeller.details(cp.label_id)

# Print the tracking references
details.tracking_reference.map {|tr| puts tr}
# download the ticket
cp_ticket = labeller.download(cp.label_id)

# Write the ticket out
File.open("#{cp.label_id}.pdf", 'w') do |f|
  f.puts(cp_ticket.read)
end
