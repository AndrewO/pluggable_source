# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pluggable_source/version"

Gem::Specification.new do |s|
  s.name        = "pluggable_source"
  s.version     = PluggableSource::VERSION
  s.authors     = ["Andrew O'Brien"]
  s.email       = ["obrien.andrew@gmail.com"]
  s.homepage    = "http://github.com/AndrewO/pluggable_source"
  s.summary     = %q{A small mixin to keep your code isolated, make testing easy, and restore happiness to your life.}
  s.description = %q{Often, we want to isolate dependencies on other classes and make them configurable at runtime. This allows easier test isolation and separation of concerns. This libary abstracts away most of the repeated code when doing that.}

  s.rubyforge_project = "pluggable_source"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
