# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  def check_status
    idfa = params[:idfa]

    @user = User.find_by(idfa:)
    @user = User.new(idfa:) if @user.nil?

    return render json: { ban_status: 'banned' } if @user.banned?

    previous_ban_status = @user.ban_status

    new_ban_status = security_checks_result
    current_user_new_record = @user.new_record?

    @user.ban_status = new_ban_status if previous_ban_status != new_ban_status
    @user.save

    create_integrity_log if current_user_new_record || previous_ban_status != new_ban_status

    render json: { ban_status: new_ban_status }, status: :ok
  end

  private

  def create_integrity_log
    params = { rooted_device: security_check_service.rooted_device?, ip: @vpn_api_response&.ip, country: @vpn_api_response&.country,
               proxy: @vpn_api_response&.proxy, vpn: @vpn_api_response&.vpn }.compact

    IntegrityLoggerService.log(
      user: @user,
      params:
    )
  end

  def security_checks_result
    if !security_check_service.country_whitelisted? ||
       security_check_service.rooted_device? ||
       security_check_service.ip_tor_or_vpn?(vpn_api_response)
      return 'banned'
    end

    'not_banned'
  end

  def security_check_service
    SecurityCheckService.new(request:, params:)
  end

  def vpn_api_response
    return @vpn_api_response if defined?(@vpn_api_response)

    ip_address = request.headers['CF-Connecting-IP']
    response = VpnApiService.new(ip_address).perform

    @vpn_api_response = VpnApiResponse.new(response)
  end
end
