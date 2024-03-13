class VpnApiResponse < HttpResponse
  def ip
    parsed_body['ip']
  end

  def country
    parsed_body['location']['country']
  end

  def proxy
    parsed_body['security']['proxy'] || false
  end

  def vpn
    parsed_body['security']['vpn']
  end
end

# VPN API RESPONSE EXAMPLE
#     {
#     "ip": "185.213.82.54",
#     "security": {
#         "vpn": true,
#         "proxy": false,
#         "tor": false,
#         "relay": false
#     },
#     "location": {
#         "city": "Taipei",
#         "region": "Taipei City",
#         "country": "Taiwan",
#         "continent": "Asia",
#         "region_code": "TPE",
#         "country_code": "TW",
#         "continent_code": "AS",
#         "latitude": "25.0504",
#         "longitude": "121.5324",
#         "time_zone": "Asia/Taipei",
#         "locale_code": "en",
#         "metro_code": "",
#         "is_in_european_union": false
#     },
#     "network": {
#         "network": "185.213.82.0/23",
#         "autonomous_system_number": "AS147049",
#         "autonomous_system_organization": "PacketHub S.A."
#     }
# }
