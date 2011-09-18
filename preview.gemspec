# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "preview/version"

Gem::Specification.new do |s|
  s.name        = "preview"
  s.version     = Preview::VERSION
  s.authors     = ["Ben Ubois"]
  s.email       = ["ben@benubois.com"]
  s.homepage    = "https://github.com/flickerbox/preview"
  s.summary     = %q{Add preview sites}
  s.description = %q{Add preview sites for the specified host. Creates the DNS, Vhost, htpasswd file and checks the site out from revision control}

  s.rubyforge_project = "preview"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "zerigo_dns"
end
