# DeliverLaterMatchers

**This gem is no longer maintained because it's functionality was merged into
[rspec-rails](https://github.com/rspec/rspec-rails)!**

* [Matcher docs](https://www.rubydoc.info/gems/rspec-rails/RSpec%2FRails%2FMatchers:have_enqueued_mail)
* [Source code](https://github.com/rspec/rspec-rails/blob/2f22bf33504c1908a3d9ef32f54da0179ebb0a15/lib/rspec/rails/matchers/have_enqueued_mail.rb)
* [rspec-rails PR](https://github.com/rspec/rspec-rails/pull/2047)

[![Gem Version](https://badge.fury.io/rb/deliver_later_matchers.svg)](https://badge.fury.io/rb/deliver_later_matchers)
[![Build Status](https://travis-ci.org/jdlubrano/deliver_later_matchers.svg?branch=master)](https://travis-ci.org/jdlubrano/deliver_later_matchers)
[![Maintainability](https://api.codeclimate.com/v1/badges/d7f9f4691169769b1ac6/maintainability)](https://codeclimate.com/github/jdlubrano/deliver_later_matchers/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d7f9f4691169769b1ac6/test_coverage)](https://codeclimate.com/github/jdlubrano/deliver_later_matchers/test_coverage)

RSpec matchers for testing that ActionMailer deliver_later is called for your
email messages.

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'deliver_later_matchers'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deliver_later_matchers

## Usage
Setup in `rails_helper.rb` or `spec_helper.rb`

```ruby
require 'deliver_later_matchers'

RSpec.configure do |config|
  config.include DeliverLaterMatchers
end
```

Use the matchers in your tests

```ruby
user = User.create

expect {
  MyMailer.welcome(user).deliver_later
}.to deliver_later(MyMailer, :welcome).with(user)

# or

user = User.create

expect {
  MyMailer.welcome(user).deliver_later
}.to enqueue_email(MyMailer, :welcome).with(user)

# or

user = User.create

expect {
  MyMailer.welcome(user).deliver_later
}.to have_enqueued_email(MyMailer, :welcome).with(user)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jdlubrano/deliver_later_matchers.
