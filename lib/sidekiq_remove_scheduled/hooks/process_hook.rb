#
# This module is responsible for clearing redis queue after job is done performing
#
# @author [Rohit Jangid]
#
module SidekiqRemoveScheduled
  module Hooks
    module ProcessHook
      def self.included(base)
        execute_job_hook base
      end
      #
      # This method is responsible for extending execute_job method
      # It search current job in redis queue and remove it from job_queue key
      #
      def self.execute_job_hook(base)
        default_execute_job = base.instance_method(:execute_job)
        base.send :define_method, :execute_job do |worker, args|
          default_execute_job.bind(self).call(worker, args)
          field = "#{worker.class.to_s}-#{args.to_s}"
          ::SidekiqRemoveScheduled::Logger.log("Processing and removing job id: #{worker.jid} for field: #{field}")
          jobs = ::SidekiqRemoveScheduled::Redis.job_queue.get(field).to_s.split(',')
          jobs.delete(worker.jid)
          if jobs.blank?
            ::SidekiqRemoveScheduled::Redis.job_queue.del(field)
          else
            ::SidekiqRemoveScheduled::Redis.job_queue.set(field, jobs.join(','))
          end
        end
      end
    end
  end
end
