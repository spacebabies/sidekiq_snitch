$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sidekiq_snitch/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sidekiq_snitch"
  s.version     = SidekiqSnitch::VERSION
  s.authors     = ["Joost Baaij"]
  s.email       = ["joost@spacebabies.nl"]
  s.homepage    = "http://www.spacebabies.nl/"
  s.summary     = "Monitor Sidekiq using Dead Mans's Snitch"
  s.description = "A Rails engine that monitors your Sidekiq install using Dead Man's Snitch (www.deadmanssnitch.com)."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.0.0"
  s.add_dependency "sidekiq", ">= 2.5.0"
end
