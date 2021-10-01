require_relative 'api_deck'
module API
 class ExceptionsToJSON
    def initialize(app)
      @app = app
    end

    def call(env)
      response = @app.call(env)
    rescue Exception => raised
      Thread.new do 
        raise raised
      end
      #$logger.error raised.backtrace
      response_data = {
        status: :INTERNAL_SERVER_ERROR,
        error: { type: :INTERNAL_SERVER_ERROR, reason: "Error desconocido" }
      }
      error = ::API::Types::ErrorResponse.new(response_data).to_h
      [ 500, { ::Rack::CONTENT_TYPE => "application/json" }, [ Oj.dump(error)] ]
    end
  end
end
