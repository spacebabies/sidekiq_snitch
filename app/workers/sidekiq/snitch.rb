require 'sidekiq'
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

        minutes = (ENV['SIDEKIQ_SNITCH_MINUTES_DELAY'] || 60).to_i.minutes

        # groundhog day!
        Snitch.perform_in(minutes) unless SidekiqSnitch.scheduled?
      end
    end
  end
end
