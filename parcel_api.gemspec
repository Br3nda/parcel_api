# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parcel_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'parcel_api'
  spec.version       = ParcelApi::VERSION
  spec.authors       = ['Robert Coleman']
  spec.email         = ['github@robert.net.nz']

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'TODO: Set to \'http://mygemserver.com\' to prevent pushes to rubygems.org, or delete to allow pushes to any server.'
  end

  spec.summary       = %q{Ruby client for NZ Post's Parcel APIs}
  spec.homepage      = 'https://github.com/etailer/parcel_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.19'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'pry', '~> 0.10'
end
