require 'faraday'
require 'faraday_middleware'

module Munich
  module API
    NEXTBUS_ENDPOINT = "http://webservices.nextbus.com/service/publicXMLFeed"
    CONNECTION = Faraday.new NEXTBUS_ENDPOINT do |conn|
      conn.response :xml
      conn.adapter Faraday.default_adapter
    end

    class Command
      attr_accessor :name, :params

      def initialize(name, params = {})
        @name = name
        @params = params
      end

      def execute
        CONNECTION.get do |req|
          req.params['command'] = name
          req.params.merge!(params)
          req.headers['X-NextBus-Command'] = name
        end
      end

      def self.agencyList
        new('agencyList')
      end

      def self.routeList(agency_tag)
        new('routeList', a: agency_tag)
      end

      def self.routeConfig(agency_tag, route_tag)
        new('routeConfig', a: agency_tag, r: route_tag)
      end

      def self.predictions(agency_tag, stop_id, route_tag = nil)
        new('predictions', a: agency_tag, stopId: stop_id, s: route_tag)
      end

      def self.predictionsForMultiStops(agency_tag, routes_and_stops)
        new('predictionsForMultiStops', stops: Munich::API::Helpers.stops_as_param(routes_and_stops))
      end

      def self.schedule(agency_tag, route_tag)
        new('schedule', a: agency_tag, r: route_tag)
      end

      def self.messages(agency_tag, route_tags)
        new('messages', a: agency_tag, r: Munich::API::Helpers.encode_array_param('r', route_tags))
      end

      def self.vehicleLocations(agency_tag, route_tag, last_check = Time.at(0))
        new('vehicleLocations', a: agency_tag, r: route_tag, t: last_check.to_i * 1000)
      end
    end

    module Helpers
      def self.encode_array_param(param_name, array)
        array.join("&#{param_name}=")
      end

      def self.stops_as_param(routes_and_stops)
        encode_array_param('stops', routes_and_stops.map {|r,s| "#{r}|#{s}"})
      end
    end
  end
end
