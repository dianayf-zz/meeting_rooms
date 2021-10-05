include Dry::Monads[:result]
module API
  class Deck < Syro::Deck

    HTTPResponses = {
      :ok => { status: 'OK', code: 200},
      :created => { status: 'CREATED', code: 201},
      :not_found => { status: 'NOT_FOUND', code: 404},
      :unauthorized => {status: 'UNAUTHORIZED', code: 401},
      :forbidden => {status: 'FORBIDDEN', code: 403},
      :input_validation_error => {status: 'UNPROCESSABLE', code: 422},
      :unprocessable => {status: 'UNPROCESSABLE', code: 422},
      :internal_server_error => {status: 'INTERNAL_SERVER_ERROR', code: 500}
    }.freeze

    def initialize
      super
    end

    def fail_with_reason(reason, status: :UNPROCESSABLE, type: :ERROR)
      error = { type: type, reason: reason }
      fail_with(error, status: status)
    end

    def handle_result(execution, success_status: :ok)
      if execution.success?
        res.status = HTTPResponses[success_status][:code]
        response =  {  
                      status: HTTPResponses[success_status][:status],
                      data: execution.value!
                     }
      else
        result = execution.failure
        type = result.fetch(:type)
        reason = result[:reason] || result[:messages]
        res.status = HTTPResponses[type][:code]
        response =  { error: 
                      { 
                        type: HTTPResponses[type][:status],
                        reason: reason 
                      }
                    }
      end 
      res.json(Oj.dump(response, use_to_hash: true, mode: :compat))
      halt res.finish
    end

    def parse_json_body
      err_msg = "Json request body invalid"
      begin
        inbox[:raw_body] ||= req.body.read.strip
        inbox[:raw_body] = "{}" if inbox[:raw_body].empty?
        parse_result = Oj.load inbox[:raw_body]
        if parse_result.class != Hash
          fail_with_reason err_msg, status: :BAD_REQUEST
        end
        inbox[:body] = parse_result
      rescue Oj::ParseError
        fail_with_reason err_msg, status: :BAD_REQUEST
      rescue EncodingError
        fail_with_reason err_msg, status: :BAD_REQUEST
      end
    end

    def json(final_response)
      # Append trace ID from the rack env if available
      final_json = Oj.dump final_response, use_to_hash: true, mode: :compat
      res.json final_json
      halt res.finish
    end

  end
end
