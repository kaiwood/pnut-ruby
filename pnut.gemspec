
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pnut/version"

Gem::Specification.new do |spec|
  spec.name = "pnut"
  spec.version = Pnut::VERSION
  spec.authors = ["Kai Wood"]
  spec.email = ["kwood@kwd.io"]

  spec.summary = %q{Convenient wrapper library around the pnut.io API}
  spec.homepage = "https://github.com/kaiwood/pnut-ruby"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.15"
  spec.add_dependency "webmock", "~> 3.4"
  spec.add_dependency "addressable", "~> 2.5"
  spec.add_dependency "eventmachine", "~> 1.2"
  spec.add_dependency "faye-websocket", "~> 0.10"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.11"
end
