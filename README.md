# SidekiqRemoveScheduled

This gem help to remove sidekiq scheduled jobs by maintaining all job ids. Just pass the arguments and this gem will take care of it.


## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq_remove_scheduled'

Config this gem using following command

    SidekiqRemoveScheduled::Redis.config(host: 'localhost', port: '6379')

Then bind this gem with your sidekiq

    SidekiqRemoveScheduled.bind


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
