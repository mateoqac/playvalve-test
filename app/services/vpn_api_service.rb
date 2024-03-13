class VpnApiService
  BASE_URL = ENV.fetch('VPN_API_URL')
  VPN_API_KEY = ENV.fetch('VPN_API_KEY')

  attr_accessor :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def perform
    HttpRequest.new(build_url).send_request
  end

  private

  def build_url
    "#{BASE_URL}#{ip_address}?key=#{VPN_API_KEY}"
  end
end
