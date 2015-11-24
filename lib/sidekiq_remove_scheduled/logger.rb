#
# This module config the logger and maintain all logging methods
#
# @author [rohit]
#
module SidekiqRemoveScheduled
  module Logger
    class << self
      attr_accessor :logger
    end
    def self.set(object)
      self.logger = object
      self
    end
    def self.log(msg)
      return if logger.nil?
      logger.info(msg)
    end
  end
end
