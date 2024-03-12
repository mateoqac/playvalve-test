require 'redis'

class RedisHelper
  def self.configure
    @redis ||= Redis.new(url: 'redis://localhost:6379/1') # Adjust the URL as needed
  end

  def self.flush_db
    @redis.flushdb
  end
end
