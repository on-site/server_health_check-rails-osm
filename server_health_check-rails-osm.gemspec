$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "server_health_check_rails_osm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "server_health_check-rails-osm"
  s.version     = ServerHealthCheckRailsOsm::VERSION
  s.authors     = ["Isaac Betesh"]
  s.email       = ["ibetesh@on-site.com"]
  s.homepage    = "https://github.com/on-site/server_health_check-rails-osm"
  s.summary     = "Related config for the server_health_check-rails gem"
  s.description = "Customized config for the server_health_check-rails gem"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_runtime_dependency "server_health_check-rails", ">= 0.2"

  s.add_development_dependency "sqlite3"
end
