module SidekiqReliableFetch
  ##
  # Encapsulates a working queue within Sidekiq.
  # Allows enumeration of all jobs within the queue.
  #
  #   queue = SidekiqReliableFetch::WorkingQueue.new("mailer")
  #   queue.each do |job|
  #     job.klass # => 'MyWorker'
  #     job.args # => [1, 2, 3]
  #   end
  #
  class WorkingQueue
    include Enumerable

    def self.all
      Sidekiq.redis { |c| c.keys('queue:*:working') }
        .sort
        .map { |q| SidekiqReliableFetch::WorkingQueue.new(q) }
    end

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def size
      Sidekiq.redis { |con| con.llen(@name) }
    end

    def each
      initial_size = size
      deleted_size = 0
      page = 0
      page_size = 50

      loop do
        range_start = page * page_size - deleted_size
        range_end   = page * page_size - deleted_size + (page_size - 1)
        entries = Sidekiq.redis do |conn|
          conn.lrange @name, range_start, range_end
        end
        break if entries.empty?
        page += 1
        entries.each do |entry|
          yield Sidekiq::Job.new(entry, @name)
        end
        deleted_size = initial_size - size
      end
    end

    def find_job(jid)
      detect { |j| j.jid == jid }
    end
  end
end
