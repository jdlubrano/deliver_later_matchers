# frozen_string_literal: true

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

    supports_block_expectations
  end
end
