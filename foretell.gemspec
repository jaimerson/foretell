lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "foretell/version"

Gem::Specification.new do |spec|
  spec.name          = "foretell"
  spec.version       = Foretell::VERSION
  spec.authors       = ["Jaimerson Araújo"]
  spec.email         = ["jaimersonaraujo@gmail.com"]

  spec.summary       = %q{Regression test selection based on graphs}
  spec.homepage      = "https://github.com/jaimerson/foretell"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "crystalball", "~> 0.7.0"
  spec.add_dependency "neo4j-core", "~> 9.0.0"
  spec.add_dependency "parser", "~> 2.5"
end
