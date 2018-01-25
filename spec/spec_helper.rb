require "bundler/setup"
require 'active_job'
require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

require "deliver_later_matchers"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    ActiveJob::Base.logger = nil
  end

  config.before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end
end

