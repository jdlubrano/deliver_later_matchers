# frozen_string_literal: true

module DeliverLaterMatchers
  class DeliverLater
    def initialize(mailer_class, method_name)
      @mailer_class = mailer_class
      @method_name = method_name
      @args = []
    end

    def description
      "deliver #{@mailer_class.name}.#{@method_name} later"
    end

    def matches?(block)
      raise ArgumentError, 'DeliverLater only works with block arguments' unless block.respond_to?(:call)
      check_job_adapter

      existing_jobs_count = enqueued_jobs.size
      block.call
      jobs_from_block = enqueued_jobs[existing_jobs_count..-1]

      matching_job_exists?(jobs_from_block)
    end

    def with(*args)
      @args = args
      self
    end

    def failure_message(block)
      "expected #{@mailer_class.name}.#{@method_name} to be delivered later"
    end

    private

    def matching_job_exists?(jobs)
      jobs.any? { |job| mailer_job?(job) && arguments_match?(job) }
    end

    def mailer_job?(job)
      job[:job] == ActionMailer::DeliveryJob
    end

    def arguments_match?(job)
      RSpec::Mocks::ArgumentListMatcher.new(*mailer_args).args_match?(*job_args(job))
    end

    # In the case where we match a mailer method that accepts
    # arguments but the test does not call `with` on the matcher,
    # we want to ignore the extra arguments passed to ActiveJob
    # when we are trying to find our `deliver_later` job.
    def job_args(job)
      ::ActiveJob::Arguments.deserialize(job[:args])[0...mailer_args.size]
    end

    def mailer_args
      [@mailer_class.name, @method_name.to_s, 'deliver_now'] + @args
    end

    def enqueued_jobs
      queue_adapter.enqueued_jobs
    end

    def queue_adapter
      ::ActiveJob::Base.queue_adapter
    end

    def check_job_adapter
      return if queue_adapter.is_a?(::ActiveJob::QueueAdapters::TestAdapter)

      raise RuntimeError, "To use DeliverLaterMatchers, set `ActiveJob::Base.queue_adapter = :test`."
    end
  end
end
