require 'sidekiq'
require 'celluloid'
require 'sidekiq/processor'
require 'sidekiq_remove_scheduled/job_hook'
require 'sidekiq_remove_scheduled/process_hook'

module Sidekiq
  module Worker
    include SidekiqRemoveScheduled::JobHook
  end
end

module Sidekiq
  class Processor
    include SidekiqRemoveScheduled::ProcessHook
  end
end
