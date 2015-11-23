require 'sidekiq_remove_scheduled/redis'
module SidekiqRemoveScheduled
  def self.bind
    if SidekiqRemoveScheduled::Redis.client.nil?
      SidekiqRemoveScheduled::Redis.config
    end
    require 'sidekiq_remove_scheduled/binder'
  end
end
