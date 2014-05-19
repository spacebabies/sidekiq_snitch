Rails.application.routes.draw do

  mount SidekiqSnitch::Engine => "/sidekiq_snitch"
end
