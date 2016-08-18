# This initializer inspects the currently scheduled Sidekiq workers,
# of which the Sidekiq::Snitch must always be one in a properly
# configured application.
#
# When none are found, schedule one to run immediately. The worker
# will then take care of rescheduling itself.
if ! SidekiqSnitch.already_scheduled && ! ENV['SIDEKIQ_SNITCH_URL'].blank?
  Sidekiq::Snitch.perform_async
end
