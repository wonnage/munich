module Munich
  class RouteMap
    def initialize(agency)
      Munich::API::Command.routeConfig('sf-muni', '38L').execute
    end
  end
end

