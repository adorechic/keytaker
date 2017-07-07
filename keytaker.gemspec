# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keytaker/version'

Gem::Specification.new do |spec|
  spec.name          = "keytaker"
  spec.version       = Keytaker::VERSION
  spec.authors       = ["adorechic"]
  spec.email         = ["adorechic@gmail.com"]

  spec.summary       = %q{A CLI tool to copy Keychain to clipboard}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/adorechic/keytaker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  spec.add_dependency 'ruby-keychain'
  spec.add_dependency 'peco_selector'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
