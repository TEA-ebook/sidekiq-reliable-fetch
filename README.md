sidekiq-reliable-fetch
======================

sidekiq-reliable-fetch is an extension to Sidekiq that adds support for reliable
fetches from Redis.

It implements in Sidekiq the reliable queue pattern using [Redis' rpoplpush
command](http://redis.io/commands/rpoplpush#pattern-reliable-queue).

## Installation

Add the following to your `Gemfile`:

```ruby
gem 'sidekiq-reliable-fetch'
```

## Configuration

Enable reliable fetches by calling this gem from your Sidekiq configuration:

```ruby
Sidekiq.configure_server do |config|
  Sidekiq::ReliableFetcher.setup_reliable_fetch!(config)

  # …
end
```

## License

LGPL-3.0, see the LICENSE file.
