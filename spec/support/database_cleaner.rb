RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:redis].strategy = :deletion
    DatabaseCleaner[:active_record].strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
