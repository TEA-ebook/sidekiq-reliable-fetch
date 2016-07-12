sidekiq-reliable-fetch
======================

# How to publish a new release?

1. Dev-commit cycle
2. Update the version in the gemspec file, commit and tag
3. Build the gem: `gem build sidekiq-reliable-fetch.gemspec`
4. Upload the gem: `gem push sidekiq-reliable-fetch-X.X.X.gem`
