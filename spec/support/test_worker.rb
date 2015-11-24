require 'sidekiq'
require 'celluloid'
class TestWorker
  include Sidekiq::Worker
  def perform(name)
    puts name
  end
end
