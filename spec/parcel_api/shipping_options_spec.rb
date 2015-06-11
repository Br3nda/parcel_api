require 'spec_helper'
require 'support/parcel_api'

describe ParcelApi::ShippingOptions, :vcr do
  let(:shipping_options) { ParcelApi::ShippingOptions.new }

  context 'Domestic Options' do
    it 'should returns a list of shipping options' do
      params = {
        weight: 10,
        length: 10,
        width: 10,
        height: 10,
        pickup_address_id: 990003,
        delivery_dpid: 2727895,
      }
      response = shipping_options.get_domestic(params)
      expect(response).to_not be_nil
    end
  end

  context 'International Options' do
    it 'should returns a list of shipping options' do
      intl_params = {
        value: 100,
        length: 10,
        height: 10,
        width: 10,
        weight: 13,
        country_code: 'AU',
      }
      response = shipping_options.get_international(intl_params)
      expect(response).to_not be_nil
    end
  end
end
