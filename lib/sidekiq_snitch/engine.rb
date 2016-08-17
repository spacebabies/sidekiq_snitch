require 'rails/engine'

module SidekiqSnitch
  class Engine < ::Rails::Engine
    isolate_namespace SidekiqSnitch
  end
end
