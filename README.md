# DeliverLaterMatchers

RSpec matchers for testing that ActionMailer deliver_later is called for your
email messages.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deliver_later_matchers'
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
}.to have_enqueued_mail(MyMailer, :welcome).with(user)
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
