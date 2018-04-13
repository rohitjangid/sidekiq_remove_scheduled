require File.expand_path("../lib/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "sidekiq_remove_scheduled"
  spec.version       = SidekiqRemoveScheduled::VERSION
  spec.authors       = ["Rohit Jangid"]
  spec.email         = ["rohitjangid@outlook.com"]
  spec.summary       = %q{Remove scheduled jobs easily}
  spec.description   = %q{Just call remove_scheduled method and pass the argument to the worker to remove scheduled jobs. No need to store Job Ids}
  spec.homepage      = "https://github.com/rohitjangid/sidekiq_remove_scheduled"
  spec.license       = "MIT"
  spec.require_paths = ["lib"]
  spec.files         = Dir["{lib}/**/*"] + ["Rakefile"]
  spec.add_dependency 'redis'
  spec.add_dependency 'redis-namespace'
  spec.add_dependency 'sidekiq'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
