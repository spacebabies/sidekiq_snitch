require 'sidekiq/api'

# This initializer inspects the currently scheduled Sidekiq workers,
# of which the Sidekiq::Snitch must always be one in a properly
# configured application.
#
# When none are found, schedule one to run immediately. The worker
# will then take care of rescheduling itself.
set = Sidekiq::ScheduledSet.new
length = set.select {|job| job.klass == "Sidekiq::Snitch" }.length

unless length > 0
  Sidekiq::Snitch.perform_async
end
