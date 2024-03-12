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
    case response
    when Net::HTTPSuccess
      # Do nothing, success
    when Net::HTTPForbidden
      @error_message = "HTTP Forbidden: #{response.code} #{response.message}"
    else
      @error_message = "HTTP Error: #{response.code} #{response.message}"
    end
  end
end
