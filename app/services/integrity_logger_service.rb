class IntegrityLoggerService
  def self.log(user:, params:)
    IntegrityLog.create(
      idfa: user.idfa,
      ban_status: user.ban_status,
      ip: params[:ip],
      rooted_device: params[:rooted_device],
      country: params[:country],
      proxy: params[:proxy],
      vpn: params[:vpn]
    )
  end
end
