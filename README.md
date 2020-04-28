# SidekiqRemoveScheduled

[![Gem Version](https://badge.fury.io/rb/sidekiq_remove_scheduled.svg)](https://badge.fury.io/rb/sidekiq_remove_scheduled)

Inspired from [Resque Scheduler](https://github.com/resque/resque-scheduler), this gem is an extension for sidekiq to remove scheduled jobs. It maintains all the job ids internally. To remove any job, you can do it with the same arguments used to schedule them.

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq_remove_scheduled'

Config this gem using following command

    SidekiqRemoveScheduled::Redis.config(host: 'localhost', port: '6379')

You can also add a logger.

    SidekiqRemoveScheduled::Logger.set(Rails.logger) # You can pass any logger object

Then bind this gem with your sidekiq

    SidekiqRemoveScheduled.bind # Run this command after all configuration


## Usage

For any worker

    class TestWorker
      include Sidekiq::Worker

      def perform(arg1, arg2)
        puts "#{agr1} #{arg2}"
      end
    end

If any job is enqueued as

    TestWorker.perform_in(5.minutes, "hello", "world")

Then dequeue this job using

    TestWorker.remove_scheduled("hello", "world")


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
