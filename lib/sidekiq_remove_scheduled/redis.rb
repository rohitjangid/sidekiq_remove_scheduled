module SidekiqRemoveScheduled
  module Redis
    class << self
      require 'redis'
      require 'redis-namespace'
      attr_accessor :client, :job_queue
    end
    def self.config(host: nil, port: nil)
      self.client = ::Redis.new(host: host, port: port)
      self.job_queue = ::Redis::Namespace.new(:queue_jobs_map, redis: client)
      self
    end
  end
end
