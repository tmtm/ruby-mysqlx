# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mysqlx/version'

Gem::Specification.new do |spec|
  spec.name          = "mysqlx"
  spec.version       = Mysqlx::VERSION
  spec.authors       = ["TOMITA Masahiro"]
  spec.email         = ["tommy@tmtm.org"]

  spec.summary       = 'Mysqlx library'
  spec.description   = 'MySQL X DevAPI for Ruby'
  spec.homepage      = 'https://github.com/tmtm/ruby-mysqlx'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir["bin/*", "lib/**/*.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'protobuf'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
