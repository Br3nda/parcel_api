require 'spec_helper'
require 'support/parcel_api'

describe ParcelApi::Label, :vcr do
  let(:label) { ParcelApi::Label.new }

  context 'Domestic CP Label' do
    let(:create_response) { label.create(cp_label_options) }

    it 'create a cp label' do
      expect(create_response).to_not be_nil
    end

    it 'get cp label details' do
      details_response = label.details(create_response.label_id)
      expect(details_response).to_not be_nil
    end

    it 'download the cp label' do
      download_response = label.download(create_response.label_id)
      expect(download_response).to_not be_nil
    end
  end

  context 'Domestic Pace Label' do
    let(:create_response) { label.create(pace_label_options) }

    it 'create a pace label' do
      expect(create_response).to_not be_nil
    end

    it 'get pace label details' do
      details_response = label.details(create_response.label_id)
      expect(details_response).to_not be_nil
    end

    it 'download the pace label' do
      download_response = label.download(create_response.label_id)
      expect(download_response).to_not be_nil
    end
  end

  # context 'Domestic Parcelpost Label' do
  #   let(:create_response) { label.create(parcelpost_label_options) }
  #
  #   it 'create a parcelpost label' do
  #     expect(create_response).to_not be_nil
  #   end
  #
  #   it 'get parcelpost label details' do
  #     details_response = label.details(create_response.label_id)
  #     expect(details_response).to_not be_nil
  #   end
  #
  #   it 'download the parcelpost label' do
  #     download_response = label.download(create_response.label_id)
  #     expect(download_response).to_not be_nil
  #   end

  # context 'International Label' do
  #   let(:create_response) { label.international_create(international_label_options) }
  #
  #   it 'create a international label' do
  #     expect(create_response).to_not be_nil
  #   end
  #
  #   it 'get international label details' do
  #     details_response = label.details(create_response.label_id)
  #     expect(details_response).to_not be_nil
  #   end
  #
  #   it 'download the international label' do
  #     download_response = label.download(create_response.label_id)
  #     expect(download_response).to_not be_nil
  #   end
  # end

  let(:cp_label_options) do
    {
      orientation: 'landscape',
      requests: [
        {
          carrier: 'COURIERPOST',
          sender_details: {
            name: 'Glenn Dodd',
            phone: '0274123456',
            email: 'glenn@example.co.nz',
            reference: '654334',
          },
          pickup_address: {
            company: 'Glenns Acme Company',
            city: 'Auckland',
            floor: 'Floor 2',
            postcode: '2102',
            street: '25 Buller Crescent',
            suburb: 'Manurewa',
            unit_type: 'Flat',
            unit_value: '2',
          },
          receiver_details: {
            name: 'Glenn Dodd',
            phone: '0274123456',
          },
          delivery_address: {
            company: 'Acme Company',
            city: 'Auckland',
            floor: 'Floor 2',
            postcode: '2102',
            street: '151 Victoria Street',
            suburb: 'Manurewa',
            unit_type: 'Flat',
            unit_value: '2',
          },
          return_indicator: 'NORMAL',
          delivery_instructions: 'Dont feed my dog tonight',
          service_code: 'CPOLE',
          add_ons: [],
          dimensions: {
            weight: '10',
            height: '35',
            width: '45',
            length: '15',
          }
        }
      ]
    }
  end

  let(:pace_label_options) do
    {
      requests: [
        {
          carrier: 'PACE',
          job_number: '987654',
          sender_details: {
            name: 'Glenn Dodd',
            phone: '0274123456',
            email: 'glenn@example.co.nz',
            customer_reference: 'ON:123456',
          },
          pickup_address: {
            company: 'Glenns Acme Company',
            unit_type: 'Flat',
            unit_value: '2',
            floor: 'Floor 2',
            street: '25 Buller Crescent',
            suburb: 'Manurewa',
            city: 'Auckland',
            postcode: '2102',
          },
          receiver_details: {
            name: 'Glenn Dodd',
            phone: '0274123456'
          },
          delivery_address: {company: 'Acme Company',
            city: 'Auckland',
            floor: 'Floor 2',
            postcode: '2102',
            street: '151 Victoria Street',
            suburb: 'Manurewa',
            unit_type: 'Flat',
            unit_value: '2'
          },
          return_indicator: 'NORMAL',
          delivery_instructions: 'Ring the bell',
          service_code: 'HDA',
          add_ons: [],
          dimensions: {
            weight: '10',
            height: '35',
            width: '45',
            length: '15'
          }
        }
      ]
    }
  end

  let(:parcelpost_label_options) do
    {
      orientation: 'landscape',
      paper_dimensions: {
        width: '210',
        height: '297',
      },
      requests: [
        {
          carrier: 'PARCELPOST',
          sender_details: {
            name: 'Test Sender Details Name',
            phone: '6490000000',
            email: 'glenn@example.co.nz',
            reference: 'ORDER20012',
            company: 'Test Sender Company',
          },
          pickup_address: {
            building: 'Test Pickup Address Building',
            city: 'Auckland',
            company: 'Test Pickup Address Company',
            floor: 'Floor 5',
            postcode: '1010',
            street: '151 Victoria Street West',
            suburb: 'Auckland Central',
            unit_type: 'Unit',
            unit_value: '2',
          },
          receiver_details: {
            name: 'Mr.Smith',
            phone: '6490000000',
            email: 'glenn@example.co.nz',
          },
          delivery_address: {
            building: 'Test Delivery Address Building',
            city: 'Auckland',
            company: 'Test Delivery Address Company',
            postcode: '0632',
            street: '42C Tawa Drive',
            suburb: 'Albany',
            unit_type: 'Suite',
            unit_value: '4',
            zone: 'East',
          },
          return_indicator: 'NORMAL',
          delivery_instructions: 'Test Delivery Instructions',
          service_code: 'PCNT5',
          add_ons: [],
          dimensions: {
            weight: '1',
            height: '10',
            width: '10',
            length: '10',
            reference: 'Test Dimensions Reference',
          }
        }
      ]
    }
  end

  let(:international_label_options) do
    {
      requests: [
        {
          sender_details: {
            name: 'The sender',
            phone: '091428774',
            email: 'the_sender@mail.com',
            reference: 'Glqddd 008',
            signatory: 'Mary Jones',
            customs_code: 'HGD34373',
          },
          pickup_address: {
            building: '',
            company: 'Express Courier Limited',
            street: '151 Victoria Street West',
            suburb: 'Auckland Central',
            city: 'Auckland',
            country_code: 'NZ',
            postcode: '1070',
          },
          receiver_details: {
            name: 'Tom Smith',
            phone: '051236547',
            vat_number: 'GB123123123123',
          },
          delivery_address: {
            building: '',
            company: 'American Express',
            street: '23 Broadway Street',
            suburb: 'Queens',
            city: 'New York',
            postcode: '4414',
            country_code: 'US',
            state: 'New York',
          },
          delivery_instructions: 'Leave at door',
          dimensions: {
            length: 600,
            width: 100,
            height: 200
          },
          undeliverable_instructions: 'RETURN',
          contents: [
            {
              unit_description: 'Light bulbs',
              unit_count: 2,
              unit_value: 5.1,
              unit_weight: 0.5,
            },
            {
              unit_description: 'Lego',
              unit_count: 10,
              unit_value: 6.1,
              unit_weight: 0.6,
            },
            {
              unit_description: 'Hot wheels',
              unit_count: 13,
              unit_value: 5.4,
              unit_weight: 0.8,
            }
          ],
          service_code: 'TIEX',
          indicia_number: '123456',
          insurance_required: true,
          contains_only_documents: true,
          export_type: 'Gift',
          harmonised_system_tariff: '12121212'
        }
      ]
    }
  end
end
