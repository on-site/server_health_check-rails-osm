$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "server_health_check/rails/osm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "server_health_check-rails-osm"
  s.version     = ServerHealthCheck::Rails::Osm::VERSION
  s.authors     = ["Mike Virata-Stone"]
  s.email       = ["mjstone@on-site.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ServerHealthCheck::Rails::Osm."
  s.description = "TODO: Description of ServerHealthCheck::Rails::Osm."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
