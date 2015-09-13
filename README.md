# ParcelApi

[![RubyGem](https://badge.fury.io/rb/parcel_api.svg)](https://rubygems.org/gems/parcel_api)[![Build Status](https://magnum.travis-ci.com/etailer/parcel_api.svg?token=hCq9S5vXdep6iBazZLuu)](https://magnum.travis-ci.com/etailer/parcel_api) [![Code Climate](https://codeclimate.com/repos/552dc72e69568025e8001d73/badges/d0ccddbcdb28ce0d2834/gpa.svg)](https://codeclimate.com/repos/552dc72e69568025e8001d73/feed) [![Test Coverage](https://codeclimate.com/repos/552dc72e69568025e8001d73/badges/d0ccddbcdb28ce0d2834/coverage.svg)](https://codeclimate.com/repos/552dc72e69568025e8001d73/feed)

Ruby wrapper for [NZ Post's Shipping APIs](https://www.nzpost.co.nz/developer-centre#parcel).

You must be a registered user of these APIs to use this gem.

__Features__

* ParcelAddress
* ShippingOptions
* ParcelPickUp
* ParcelLabel
* ParcelTrack

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'parcel_api'
```

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install parcel_api`

## Usage

### Configuration Options

By default credentials are taken from the local environment, for this to work the following ENV variables must be set:

* `ENV['CLIENT_ID']`
* `ENV['CLIENT_SECRET']`
* `ENV['USERNAME']`
* `ENV['PASSWORD']`

You can also configure credentials via `ParcelApi::Client.new`:

```ruby
client = ParcelApi::Client.new.tap do |config|
  config.client_id     = ENV['CLIENT_ID']
  config.client_secret = ENV['CLIENT_SECRET']
  config.username      = ENV['USERNAME']
  config.password      = ENV['PASSWORD']
  config.address       = 'https://api.uat.nzpost.co.nz/' # defaults to api.nzpost.co.nz
end
```

Client connections can be passed to each method:

`ParcelApi::Address(client.connection)`

## Documentation

Documentation is available [here](http://www.rubydoc.info/github/etailer/parcel_api)

Some usage examples are also available [here](example/mock.rb)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

1. Fork it ( https://github.com/etailer/parcel_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
