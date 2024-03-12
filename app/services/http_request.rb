require 'net/http'

class HttpRequest
  attr_reader :url, :method

  def initialize(url, method = 'GET')
    @url = URI.parse(url)
    @method = method
  end

  def send_request
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')

    request = create_request
    http.request(request)
  end

  private

  def create_request
    request_class = Net::HTTP.const_get(method.capitalize.to_s)
    request_class.new(url.path)
  end
end
