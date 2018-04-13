#
# This class require all files and include hooks in sidekiq modules
#
# @author [Rohit Jangid]
#

require 'sidekiq'
require 'sidekiq/processor'
require 'sidekiq_remove_scheduled/logger'
require 'sidekiq_remove_scheduled/hooks/job_hook'
require 'sidekiq_remove_scheduled/hooks/process_hook'

module Sidekiq
  module Worker
    include SidekiqRemoveScheduled::Hooks::JobHook
  end
end

module Sidekiq
  class Processor
    include SidekiqRemoveScheduled::Hooks::ProcessHook
  end
end
