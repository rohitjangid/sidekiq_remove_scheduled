require 'sidekiq_remove_scheduled/redis'
require 'sidekiq_remove_scheduled/logger'
module SidekiqRemoveScheduled
  #
  # This method bind sidekiq_remove_scheduled gem to sidekiq gem
  # extend default methods and provide extra methods
  #
  def self.bind
    if SidekiqRemoveScheduled::Redis.client.nil?
      SidekiqRemoveScheduled::Redis.config
    end
    require 'sidekiq_remove_scheduled/binder'
  end
end
