RSpec.describe SidekiqRemoveScheduled::Redis do
  describe ".config" do
    it "should config redis module" do
      SidekiqRemoveScheduled::Redis.config
      expect(SidekiqRemoveScheduled::Redis.client).not_to be_nil
      expect(SidekiqRemoveScheduled::Redis.job_queue).not_to be_nil
    end
  end
end
