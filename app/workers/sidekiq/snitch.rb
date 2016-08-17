require 'sidekiq'
require 'sidekiq/api'
require 'net/http'

# A worker to contact deadmanssnitch.com periodically,
# thereby ensuring jobs are being performed and the system
# is healthy.
module Sidekiq
  class Snitch
    include Sidekiq::Worker

    def perform
      if ENV['SIDEKIQ_SNITCH_URL'].present?
        Net::HTTP.get(URI(ENV['SIDEKIQ_SNITCH_URL']))

        already_scheduled = Sidekiq::ScheduledSet.new.any? {|job| job.klass == "Sidekiq::Snitch" }
        # groundhog day!
        Snitch.perform_in(1.hour) unless already_scheduled
      end
    end
  end
end
