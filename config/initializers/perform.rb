require 'sidekiq/api'

# This initializer inspects the currently scheduled Sidekiq workers,
# of which the Sidekiq::Snitch must always be one in a properly
# configured application.
#
# When none are found, schedule one to run immediately. The worker
# will then take care of rescheduling itself.
set = Sidekiq::ScheduledSet.new
already_scheduled = set.any? {|job| job.klass == "Sidekiq::Snitch" }

if ! already_scheduled && ! ENV['SIDEKIQ_SNITCH_URL'].blank?
  Sidekiq::Snitch.perform_async
end
