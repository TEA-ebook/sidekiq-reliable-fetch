Gem::Specification.new do |s|
  s.name        = 'sidekiq-reliable-fetch'
  s.version     = '0.2.3'
  s.authors     = ['TEA']
  s.email       = 'technique@tea-ebook.com'
  s.license     = 'LGPL-3.0'
  s.homepage    = 'https://github.com/TEA-ebook/sidekiq-reliable-fetch'
  s.summary     = 'Reliable fetch extension for Sidekiq'
  s.description = 'Redis reliable queue pattern implemented in Sidekiq'
  s.require_paths = ['lib']

  s.files = `git ls-files`.split($\)
  s.test_files  = []

  s.add_dependency 'sidekiq', '~> 3'
end
