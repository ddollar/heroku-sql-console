# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heroku-sql-console/version"

Gem::Specification.new do |s|
  s.name        = "heroku-sql-console"
  s.version     = Heroku::Command::Sql::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Dollar", "Terence Lee"]
  s.email       = ["ddollar@gmail.com", "hone02@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Plugin that provides a sql console for your heroku app.}
  s.description = %q{Plugin that provides a sql console for your heroku app. }

  s.rubyforge_project = "heroku-sql-console"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
