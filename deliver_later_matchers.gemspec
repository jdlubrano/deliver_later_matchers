lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deliver_later_matchers/version'

Gem::Specification.new do |spec|
  spec.name          = 'deliver_later_matchers'
  spec.version       = DeliverLaterMatchers::VERSION
  spec.licenses      = ['MIT']
  spec.authors       = ['Joel Lubrano']
  spec.email         = ['joel.lubrano@gmail.com']

  spec.summary       = 'RSpec matchers for testing that ActionMailers deliver_later'
  spec.homepage      = 'https://github.com/jdlubrano/deliver_later_matchers'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionmailer', '>= 4.0'
  spec.add_dependency 'activejob', '>= 4.0'
  spec.add_dependency 'rspec-expectations', '~> 3.0'
  spec.add_dependency 'rspec-mocks', '~> 3.0'
  spec.add_dependency 'rspec-rails', '~> 3.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'byebug', '~> 9.1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.15'
end
