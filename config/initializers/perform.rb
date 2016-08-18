# This initializer inspects the currently scheduled Sidekiq workers,
# of which the Sidekiq::Snitch must always be one in a properly
# configured application.
#
# When none are found, schedule one to run immediately. The worker
# will then take care of rescheduling itself.

if ENV['SIDEKIQ_SNITCH_URL'].present?
  Sidekiq.configure_server do |config|
    config.on(:startup) do
      already_scheduled = Sidekiq::ScheduledSet.new.any? {|job| job.klass == "Sidekiq::Snitch" }
      Sidekiq::Snitch.perform_async unless already_scheduled
    end
  end
end
