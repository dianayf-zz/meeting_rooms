module API
  class Deck < Syro::Deck

    def initialize(headers = {})
      super(headers)
    end

    def require_token
    end

    def handle_result(execution, success_status: :OK)
    end

    def parse_json_body
    end
  end
end
