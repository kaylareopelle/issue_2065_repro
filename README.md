# README

This application is an attempt to reproduce newrelic/newrelic-ruby-agent [Issue \#2065](https://github.com/newrelic/newrelic-ruby-agent/issues/2065)
It uses an abbreviated version of the Sidekiq example `myapp`, which can be found at: https://github.com/sidekiq/sidekiq/tree/main/myapp

The following libraries/versions were used to mimic the customer's environment:
* ruby 3.1.2
* rails 6.1.7.3
* sidekiq 7.1.2 - version was unstated by the customer, this is the latest version
* newrelic_rpm 9.2.2
* sentry-rails 5.9.0
* sentry-ruby 5.9.0
* sentry-sidekiq 5.9.0

Before getting started:
* Add your New Relic license key to `config/newrelic.yml` or via the NEW_RELIC_LICENSE_KEY environment variable
* Add your Sentry DNS link to `config/initializers/sentry.rb`
* Install Ruby 3.1.2
* Install [foreman](https://github.com/ddollar/foreman), using `gem install foreman`
* Install [redis](https://redis.io/docs/getting-started/)
  * I'm on a Mac and used Homebrew:
    * `brew install redis`
    * `brew services start redis`

To run the application:
* `bundle install`
* `foreman start`

I took the following steps to attempt to reproduce the issue:
* Visit localhost:5000/job
* Allow the enqueued jobs to finish running
* Shut down the application using CTRL+C

These steps resulted in a successful shutdown, with the following logged messages:
```
16:46:38 web.1  | Exiting
16:46:38 web.1  | Shutting down background worker
16:46:38 web.1  | Killing session flusher
16:46:38 web.1  | ** [NewRelic][2023-06-28 16:46:38 -0700 [REDACTED]] INFO : Starting Agent shutdown
16:46:38 web.1  | ** [NewRelic][2023-06-28 16:46:38 -0700 [REDACTED]] DEBUG : Exiting AgentThread: Worker Loop
16:46:38 web.1  | ** [NewRelic][2023-06-28 16:46:38 -0700 [REDACTED]] DEBUG : Sending data to New Relic Service
```
