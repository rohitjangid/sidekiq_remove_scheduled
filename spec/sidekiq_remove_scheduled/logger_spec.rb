RSpec.describe SidekiqRemoveScheduled::Logger do
  let(:test_logger) { Class.new }
  describe ".set" do
    it "should initialize logger" do
      SidekiqRemoveScheduled::Logger.set(test_logger)
      expect(SidekiqRemoveScheduled::Logger.logger).to eql(test_logger)
    end
  end
  describe ".log" do
    context "if logger is set" do
      before(:each) do
        SidekiqRemoveScheduled::Logger.logger = test_logger
      end
      it "should log info msg via logger" do
        expect(SidekiqRemoveScheduled::Logger.logger).to receive(:info).with('random')
        SidekiqRemoveScheduled::Logger.log('random')
      end
    end
    context "if logger is not set" do
      before(:each) do
        SidekiqRemoveScheduled::Logger.logger = nil
      end
      it "should return" do
        expect(SidekiqRemoveScheduled::Logger.logger.nil?).to be true
        expect(SidekiqRemoveScheduled::Logger.log('random')).to be_nil
      end
    end
  end
end
