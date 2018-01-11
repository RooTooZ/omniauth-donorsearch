lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path('../lib/omniauth-donorsearch/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "omniauth-donorsearch"
  spec.version       = Omniauth::Donorsearch::VERSION
  spec.authors       = ["Konstantin T"]
  spec.email         = ["mrootooz@gmail.com"]

  spec.summary       = %q{Donorsearch.org OAuth2 Strategy for OmniAuth}
  spec.homepage      = "http://donorsearch.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.2'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
