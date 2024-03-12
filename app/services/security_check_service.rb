class SecurityCheckService
  attr_reader :request, :params

  def initialize(request:, params:)
    @request = request
    @params = params
  end

  def country_whitelisted?
    whitelisted_countries = RedisService.instance.smembers('whitelisted_countries') || []
    whitelisted_countries.include?(request.headers['CF-IPCountry'].downcase)
  end

  def rooted_device?
    params[:rooted_device] == 'true'
  end

  def ip_tor_or_vpn?(vpn_api_response)
    return false unless request.headers['CF-Connecting-IP']

    ip_address = request.headers['CF-Connecting-IP']
    cached_result = RedisService.instance.get("vpnapi:#{ip_address}")

    return true if cached_result && cached_result['vpn'] == 'true'

    return false unless vpn_api_response.success?

    RedisService.instance.setex("vpnapi:#{ip_address}", 24 * 60 * 60, { vpn: vpn_api_response.vpn }.to_json)

    vpn_api_response.vpn || vpn_api_response.proxy
  end
end
