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

        # groundhog day!
        delay = ENV['SIDEKIQ_SNITCH_DELAY_MINUTES'].to_i
        delay = 60 if delay <= 0
        Snitch.perform_in(delay.minutes)
      end
    end
  end
end
