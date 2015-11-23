module SidekiqRemoveScheduled
  module JobHook
    def self.included(base)
      base.extend ClassMethods
    end
    module ClassMethods
      def self.extended(base)
        perform_in_hook base
        remove_scheduled_jobs base
      end
      def self.perform_in_hook(base)
        default_perform_in = base::ClassMethods.instance_method(:perform_in)
        base::ClassMethods.send :define_method, :perform_in do |interval, *args|
          jid = default_perform_in.bind(self).call(interval, *args)
          field = "#{self.to_s}-#{args.to_s}"
          jobs = SidekiqRemoveScheduled::Redis.job_queue.get(field).to_s.split(',')
          jobs << jid
          SidekiqRemoveScheduled::Redis.job_queue.set(field, jobs.uniq.join(','))
        end
        base::ClassMethods.send :alias_method, :perform_at, :perform_in
      end
      def self.remove_scheduled_jobs(base)
        base::ClassMethods.send :define_method, :remove_scheduled do |*args|
          field = "#{self.to_s}-#{args.to_s}"
          jobs = SidekiqRemoveScheduled::Redis.job_queue.get(field).to_s.split(',')
          jobs.each do |job_id|
            pattern = '*,\"jid\":\"'+job_id+'\",*'
            itterator = 0
            begin
              job = SidekiqRemoveScheduled::Redis.client.zscan('schedule', itterator, match: pattern)
              itterator = job.first.to_i
            end until job.last.present? || itterator == 0
            SidekiqRemoveScheduled::Redis.client.zrem('schedule', job.last.first) if job.last.present?
          end
          SidekiqRemoveScheduled::Redis.job_queue.del(field)
        end
      end
    end
  end
end
