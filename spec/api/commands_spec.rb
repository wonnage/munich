require 'spec_helper'

describe Munich::API::Command do
  it 'supports commands with no arguments' do
    expect { Munich::API::Command.new('foo') }.to_not raise_error
  end

  describe 'vehicleLocations' do
    it 'encodes time in msec' do
      t = Time.now
      cmd = Munich::API::Command.vehicleLocations('sf-muni', 'n', t)

      puts cmd.params
      cmd.params[:t].should == t.to_i * 1000
    end
  end
end

describe Munich::API::Helpers do
  describe 'stops_as_param' do
    it 'should encode a single stop' do
      Munich::API::Helpers.stops_as_param(n: 1234).should == 'n|1234'
    end

    it 'should encode multiple stops as additional `stops` parameters' do
      Munich::API::Helpers.stops_as_param(n: 1234, m: 5678, t: 9876).should == 'n|1234&stops=m|5678&stops=t|9876'
    end
  end

  describe 'encode_array_param' do
    it 'should encode a single item' do
      Munich::API::Helpers.encode_array_param('fooParam', ['bar']).should == 'bar'
    end

    it 'should encode multiple items' do
      Munich::API::Helpers.encode_array_param('fooParam', ['bar', 'baz', 'quux']).should == 'bar&fooParam=baz&fooParam=quux'
    end
  end
end
