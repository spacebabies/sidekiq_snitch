require "sidekiq_snitch/engine"
require 'sidekiq/api'

module SidekiqSnitch
  def self.scheduled?
    Sidekiq::ScheduledSet.new.any? {|job| job.klass == "Sidekiq::Snitch" }
  end
end
