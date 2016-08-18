# Scheduled a Sidekiq::Snitch worker to monitor Sidekiq using
# Dead Man's Snitch (www.deadmanssnitch.com).
Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq::Snitch.perform_async unless SidekiqSnitch.scheduled?
  end
end
