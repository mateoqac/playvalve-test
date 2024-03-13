module RedisService
  def self.instance
    redis_config = Rails.application.config_for(:redis)
    Redis.new(url: redis_config['url'])
  rescue Redis::BaseConnectionError => e
    Rails.logger.error("Error connecting to Redis: #{e.message}")
  end
end
