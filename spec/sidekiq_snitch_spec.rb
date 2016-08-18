require 'spec_helper'

describe Sidekiq::Snitch, type: :unit do
  it "is false when no worker is scheduled" do
    expect(SidekiqSnitch.scheduled?).to be_falsy
  end

  it "indicates if a worker is already scheduled" do
    stub_request :get, 'example.com'
    ENV['SIDEKIQ_SNITCH_URL'] = 'http://example.com'
    Sidekiq::Snitch.new.perform
    ENV.delete('SIDEKIQ_SNITCH_URL')
    expect(SidekiqSnitch.scheduled?).to be_truthy
  end
end
