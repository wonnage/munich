module Munich::API
  class ResponseMiddleware
    def call(env)
      command = env[:request_headers]['X-NextBus-Command']
      @app.call(env).on_complete do
        env[:body] = parse(command, env[:body])
      end
    end

    def parse(commandType, input)
      case commandType
      end
    end
  end
end

