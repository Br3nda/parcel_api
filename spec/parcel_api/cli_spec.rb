require 'spec_helper'
require 'parcel_api/cli'

describe ParcelApi::CLI do
  it 'is a Thor CLI' do
    expect(subject.is_a?(Thor)).to eql(true)
  end

  describe '#version' do
    let(:output) { capture(:stdout) { subject.version } }

    it 'displays the version number' do
      expect(output).to include(ParcelApi::VERSION)
    end
  end
end
