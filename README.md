# sidekiq_snitch

Rails engine to monitor your Sidekiq queue using Dead Man's Snitch.

# NOT MAINTAINED

I‘ve stopped maintaining this gem, since I think [OkComputer](https://github.com/sportngin/okcomputer) is a superior solution to monitoring your Sidekiq queue. You would add one for each queue, and then check the /okcomputer endpoint for everything. For Sidekiq, that would mean:

``` ruby
OkComputer::Registry.register "sidekiq - default", OkComputer::SidekiqLatencyCheck.new('default')
OkComputer::Registry.register "sidekiq - mailers", OkComputer::SidekiqLatencyCheck.new('mailers')
# and so on, one for each queue.
```

If you would like to maintain this repo or a fork, get in touch. All other issues and pull requests will be closed.

# Installation

First, create an account at [Dead Man's Snitch](http://www.deadmanssnitch.com/).

Then, create an hourly snitch. Put its value in `ENV['SIDEKIQ_SNITCH_URL']`.

By default the snitch is triggered every hour, it's possible to set less or more time setting this variable: `ENV['SIDEKIQ_SNITCH_MINUTES_DELAY']``

In Gemfile:

```
gem 'sidekiq_snitch'
```

and run `bundle`. Deploy et voila!

# FAQ

Question: How can I see if Sidekiq::Snitch is running and a worker is scheduled?

Answer: In your Rails console, run this:

```
SidekiqSnitch.scheduled? # => returns true or false
```

Question: Why use an external system and not a simple cron job?

Answer: If you use Sidekiq to run tasks in the background, you should monitor it.
Monitoring any system using the system itself is asking for trouble. Using an external
tool that starts to yell when something is wrong is the most sensible thing to do.

You can use any old monitoring tool, but we've found that Dead Man's Snitch is
simple and does one thing really well. It's also very useful for monitoring cron, in
fact.

Question: What is ENV?

Answer: create an initializer:

```
# config/initializers/sidekiq_snitch.rb
ENV['SIDEKIQ_SNITCH_URL'] = "https://snitch.url.example.com"
```

Question: Can I turn this off in my development environment?

Answer: Sure! Just make sure there is no value set for `ENV['SIDEKIQ_SNITCH_URL']`.
Sidekiq Snitch only runs if it has somewhere to snitch.

# Testing

If you want to help develop this plugin, clone the repo and bundle to get all dependencies.

Then to run the tests:

```
rspec
```

# Created by

[Space Babies](https://www.spacebabies.nl/)

Get in touch: joost@spacebabies.nl

# License

MIT.
