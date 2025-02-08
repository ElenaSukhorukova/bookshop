require 'capybara/rails'
require 'database_cleaner/active_record'

RSpec.configure do |config|
  # https://github.com/DatabaseCleaner/database_cleaner#rspec-with-capybara-example
  # https://avdi.codes/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
  config.before(:suite) do
    if config.use_transactional_fixtures?
      raise <<-MSG
        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
        (or set it to false) to prevent uncommitted transactions being used in
        JavaScript-dependent specs.

        During testing, the app-under-test that the browser driver connects to
        uses a different database connection to the database connection used by
        the spec. The app's database connection would not be able to access
        uncommitted transaction data setup over the spec's database connection.
      MSG
    end

    # If you’re using Active Record, the except statement is essential.
    # Without it, the database_cleaner will destroy Active Record’s environment data,
    # resulting in a NoEnvironmentInSchemaError every time your tests run.
    DatabaseCleaner.clean_with :truncation, except: %w[ar_internal_metadata]
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  # This line only runs before examples which have been flagged :js => true.
  # By default, these are the only tests for which Capybara fires up a test server process
  # and drives an actual browser window via the Selenium backend. For these types of tests,
  # transactions won’t work, so this code overrides the setting and chooses the “truncation” strategy instead.
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
  end

  config.append_after do
    DatabaseCleaner.clean
  end
end
