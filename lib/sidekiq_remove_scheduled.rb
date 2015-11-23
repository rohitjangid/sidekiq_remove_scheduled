require 'sidekiq_remove_scheduled/redis'
require 'sidekiq_remove_scheduled/logger'
module SidekiqRemoveScheduled
  def self.bind
    if SidekiqRemoveScheduled::Redis.client.nil?
      SidekiqRemoveScheduled::Redis.config
    end
    require 'sidekiq_remove_scheduled/binder'
  end
end
