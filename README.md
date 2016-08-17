# sidekiq_snitch

Rails engine to monitor your Sidekiq queue using Dead Man's Snitch.

# Installation

First, create an account at [Dead Man's Snitch](http://www.deadmanssnitch.com/).

Then, create an hourly snitch. Put its value in `ENV['SIDEKIQ_SNITCH_URL']`.

In Gemfile:

```
gem 'sidekiq_snitch'
```

and run `bundle`. Deploy et voila!

# FAQ

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
