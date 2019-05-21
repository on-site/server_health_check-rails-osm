# ServerHealthCheckRailsOsm

This gem serves 3 roles:

1. Make the server health check URL available via HTTP even when at the application level, config.ssl_only is true.
2. Make the server health check URL use a different log file than the rest of the application.
   If the server health check URL is being pinged by monitoring tools every few seconds, it creates a log of noise
   in the logs.  Instead of logging to production.log like all other requests, it instead logs to health_check.log.
3. Ensure that we've attempted to establish a connection to the DB before requests to the server health check URL
   check that it's connected.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'server_health_check-rails-osm'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install server_health_check-rails-osm
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
