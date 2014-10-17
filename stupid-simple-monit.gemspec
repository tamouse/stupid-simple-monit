# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "stupid-simple-monit"
  spec.version       = "0.0.2"
  spec.authors       = ["Tamara Temple", "Kyle Kestell"]
  spec.email         = ["tamouse@gmail.com", "kyle@kestell.org"]
  spec.summary       = "A stupid, dead-simple, process monitor."
  spec.homepage      = "http://github.com/tamouse/stupid-simple-monit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "aruba"
end
