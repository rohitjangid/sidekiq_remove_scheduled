require 'support/test_worker'
RSpec.describe SidekiqRemoveScheduled do
  describe ".bind" do
    it "should bind gem to sidekiq workers" do
      expect(TestWorker.respond_to? :remove_scheduled).to be false
      SidekiqRemoveScheduled.bind
      expect(TestWorker.respond_to? :remove_scheduled).to be true
    end
  end
  describe "behaviour" do
    before(:each) do
      @field = "TestWorker-#{["hello"].to_s}"
      @job_queue = SidekiqRemoveScheduled::Redis.job_queue
      @job_queue.del(@field)
    end
    it "should add jid to redis for scheduled jobs" do
      expect(@job_queue.get(@field)).to be_nil
      TestWorker.perform_in(1*60, "hello")
      expect(@job_queue.get(@field)).not_to be_nil
      TestWorker.perform_at(Time.now.to_i + 1*60, "hello")
      expect(@job_queue.get(@field)).not_to be_nil
    end
    it "should remove scheduled jobs matching arguments" do
      expect(@job_queue.get(@field)).to be_nil
      TestWorker.perform_in(1*60, "hello")
      expect(@job_queue.get(@field)).not_to be_nil
      TestWorker.remove_scheduled("hello")
      expect(@job_queue.get(@field)).to be_nil
    end
  end
end
