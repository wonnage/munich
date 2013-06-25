module Munich
  class Router
    attr_accessor :agency

    def initialize(agency)
      @agency = agency
    end

    # origin, destination: Geokit::LatLng representing the start and end points.
    # Returns a list of routes.
    #
    def route(origin, destination)
    end
  end
end


