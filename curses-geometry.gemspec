lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "curses/geometry/version"

Gem::Specification.new do |spec|
  spec.name          = "curses-geometry"
  spec.version       = Curses::Geometry::VERSION
  spec.authors       = ["Julien Jassaud"]
  spec.email         = ["sojastar07@gmail.com"]

  spec.summary       = %q{Adds some basic graphic primitives to the Curses module.}
  spec.description   = %q{Adds some basic graphic primitives to the Curses module. It can draw single glyphs, lines and antialiased lines, frames and filled rectangles, and arbitrary convex polygons.}
  spec.homepage      = "https://rubygems.org/gems/curses-geometry"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/sojastar/curses-geometry.git"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency     "curses", "~> 1.2.4"
end
