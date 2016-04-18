# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keg/version'

Gem::Specification.new do |spec|
  spec.name          = "keg"
  spec.version       = Keg::VERSION
  spec.authors       = ["yuta-muramoto"]
  spec.email         = ["s1513114@u.tsukuba.ac.jp"]

  spec.summary       = %q{This is CLI tool that supports a data management.}
  spec.description   = <<-EOF
  Keg use the data formatted by TOML which is language that easy to read.
  Keg read a TOML file from the local database and outputs its useful format.
  You need to clone the repository has the TOML file in the local database (`$HOME/.keg/databases`) in advance.
  EOF
  spec.homepage      = "https://github.com/bm-sms/keg"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "toml-rb"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
end
