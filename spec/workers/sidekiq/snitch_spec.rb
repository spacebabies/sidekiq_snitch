require 'spec_helper'

RSpec.describe Sidekiq::Snitch, type: :unit do
  let(:snitch_url) { 'http://example.com' }
  let!(:stub) { stub_request(:get, snitch_url) }

  def already_scheduled
    Sidekiq::ScheduledSet.new.any? {|job| job.klass == "Sidekiq::Snitch" }
  end

  describe "with SIDEKIQ_SNITCH_URL" do
    before do
      ENV['SIDEKIQ_SNITCH_URL'] = snitch_url
    end

    after do
      Sidekiq::ScheduledSet.new.each {|worker| worker.delete }
      ENV.delete('SIDEKIQ_SNITCH_URL')
    end

    it "visits the SIDEKIQ_SNITCH_URL" do
      Sidekiq::Snitch.new.perform
      expect(stub).to have_been_requested
    end

    it "schedules a Sidekiq::Snitch" do
      Sidekiq::Snitch.new.perform
      expect(already_scheduled).to be_truthy
    end
  end

  describe "with no SIDEKIQ_SNITCH_URL" do
    it "does no http request" do
      Sidekiq::Snitch.new.perform
      expect(stub).to_not have_been_requested
    end

    it "does not schedule a Sidekiq::Snitch" do
      Sidekiq::Snitch.new.perform
      expect(already_scheduled).to be_falsy
    end
  end
end
