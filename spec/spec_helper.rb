require 'rspec'
require 'sidekiq'
require 'rails/all'
require 'webmock/rspec'

require 'sidekiq_snitch'
require_relative '../app/workers/sidekiq/snitch'

RSpec.configure do |config|
  config.after(:each) do
    Sidekiq::ScheduledSet.new.each {|worker| worker.delete }
  end
end
