class HttpResponse
  attr_reader :code, :body, :error_message

  def initialize(response)
    @code = response.code
    @body = response.body
    @error_message = nil

    handle_errors(response)
  end

  def success?
    error_message.nil?
  end

  def parsed_body
    JSON.parse(@body)
  end

  private

  def handle_errors(response)
    @error_message = case response.code.to_i
                     when 200
                       return nil
                     when 403
                       "HTTP Forbidden: #{response.code} #{response.message}"
                     else
                       "HTTP Error: #{response.code} #{response.message}"
                     end
  end
end
