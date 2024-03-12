require 'redis'

namespace :whitelist do
  desc 'Populate whitelisted_countries key in Redis with downcased country names'

  task countries: :environment do
    redis = Redis.new

    countries = YAML.load_file('lib/files/whitelisted_countries.yml')

    downcased_countries = countries.map(&:downcase)

    redis.sadd('whitelisted_countries', downcased_countries)

    puts 'whitelisted_countries key populated in Redis.'
  end
end
