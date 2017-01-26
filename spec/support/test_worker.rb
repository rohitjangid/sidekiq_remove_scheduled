require 'sidekiq'
require 'celluloid/current'
class TestWorker
  include Sidekiq::Worker
  def perform(name)
    puts name
  end
end
