require 'byebug'

require 'active_job'
require 'action_mailer'

RSpec.describe DeliverLaterMatchers do
  it "has a version number" do
    expect(DeliverLaterMatchers::VERSION).not_to be nil
  end

  describe 'matchers' do
    include DeliverLaterMatchers

    class TestMailer < ActionMailer::Base
      def test_email
      end

      def email_with_args(foo)
      end
    end

    describe 'deliver_later' do
      it do
        expect { TestMailer.test_email.deliver_later }
          .to deliver_later(TestMailer, :test_email)
      end

      context 'when ActiveJob::QueueAdapter is not :test' do
        it do
          ActiveJob::Base.queue_adapter = :async

          expect { expect { TestMailer.test_email.deliver_later }.to deliver_later(TestMailer, :test_email) }
            .to raise_error(RuntimeError,  "To use DeliverLaterMatchers, set `ActiveJob::Base.queue_adpater = :test`.")
        end
      end
    end
  end
end
