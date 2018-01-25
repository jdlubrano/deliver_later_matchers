# frozen_string_literal: true

require 'rspec/expectations'

require 'deliver_later_matchers/version'
require 'deliver_later_matchers/deliver_later'

module DeliverLaterMatchers
  extend RSpec::Matchers::DSL

  matcher :deliver_later do |mailer_class, method_name|
    matcher = DeliverLater.new(mailer_class, method_name)

    match do |block|
      matcher.matches?(block)
    end

    description do
      matcher.description
    end

    chain :with do |*args|
      matcher.with(*args)
    end

    failure_message do |block|
      matcher.failure_message(block)
    end

    supports_block_expectations
  end

  RSpec::Matchers.alias_matcher :enqueue_email, :deliver_later
  RSpec::Matchers.alias_matcher :have_enqueued_email, :deliver_later
end
