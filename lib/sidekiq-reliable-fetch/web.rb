require_relative 'api'

module SidekiqReliableFetch
  # Hook into *Sidekiq::Web* Sinatra app which adds a new '/working' page
  module Web
    VIEW_PATH = File.expand_path('../../../web/views', __FILE__)

    def self.registered(app)
      app.get '/working' do
        @queues = SidekiqReliableFetch::WorkingQueue.all
        erb File.read(File.join(VIEW_PATH, 'working_queues.erb'))
      end

      app.get '/working/:queue' do
        @queue = SidekiqReliableFetch::WorkingQueue.new(params[:queue])
        erb File.read(File.join(VIEW_PATH, 'working_queue.erb'))
      end
    end
  end
end

require 'sidekiq/web' unless defined?(Sidekiq::Web)
Sidekiq::Web.register(SidekiqReliableFetch::Web)
Sidekiq::Web.tabs['Working'] = 'working'
