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

      def email_with_args(arg1, arg2)
      end
    end

    describe 'deliver_later' do
      it do
        expect { TestMailer.test_email.deliver_later }
          .to deliver_later(TestMailer, :test_email)
      end

      it 'does not produce false positives' do
        expect { TestMailer.test_email.deliver_later }
          .not_to deliver_later(TestMailer, :email_with_args)
      end

      it 'matches methods with arguments' do
        expect { TestMailer.email_with_args('arg1', 'arg2').deliver_later }
          .to deliver_later(TestMailer, :email_with_args)
      end

      context 'when ActiveJob::QueueAdapter is not :test' do
        it do
          ActiveJob::Base.queue_adapter = :async

          expect { expect { TestMailer.test_email.deliver_later }.to deliver_later(TestMailer, :test_email) }
            .to raise_error(RuntimeError,  "To use DeliverLaterMatchers, set `ActiveJob::Base.queue_adapter = :test`.")
        end
      end

      context 'with args' do
        it do
          expect { TestMailer.email_with_args('arg1', 'arg2').deliver_later }
            .to deliver_later(TestMailer, :email_with_args).with('arg1', 'arg2')
        end

        it 'does not produce false positives' do
          expect { TestMailer.email_with_args('arg1', 'arg2').deliver_later }
            .not_to deliver_later(TestMailer, :email_with_args).with('arg1', 'not_an_arg')
        end
      end

      context 'failure message' do
        it 'describes the mailer and method that is supposed to be delivered later' do
          error_message = 'expected TestMailer.test_email to be delivered later'

          expect { expect { }.to deliver_later(TestMailer, :test_email) }
            .to raise_error RSpec::Expectations::ExpectationNotMetError, error_message
        end
      end
    end

    describe 'enqueue_email' do
      it do
        expect { TestMailer.test_email.deliver_later }
          .to enqueue_email(TestMailer, :test_email)
      end

      context 'with args' do
        it 'matches methods with arguments' do
          expect { TestMailer.email_with_args('arg1', 'arg2').deliver_later }
            .to enqueue_email(TestMailer, :email_with_args).with('arg1', 'arg2')
        end
      end
    end

    describe 'have_enqueued_email' do
      it do
        expect { TestMailer.test_email.deliver_later }
          .to have_enqueued_email(TestMailer, :test_email)
      end

      context 'with args' do
        it 'matches methods with arguments' do
          expect { TestMailer.email_with_args('arg1', 'arg2').deliver_later }
            .to have_enqueued_email(TestMailer, :email_with_args).with('arg1', 'arg2')
        end
      end
    end
  end
end
