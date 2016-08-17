require 'rspec'
require 'sidekiq'
require 'rails/all'
require 'webmock/rspec'

require 'sidekiq_snitch'
require_relative '../app/workers/sidekiq/snitch'
