require 'sneakers'

config = {:timeout_job_after => 5,
        :prefetch => 10,
        :threads => 10,
        :env => ENV['RACK_ENV'],
        :durable => true,
        exchange_options: {
          type: 'direct',
          durable: true
        },
        queue_options:    {
          durable: true
        },
        :ack => true,
        :heartbeat => 2,
        :exchange => 'snickers',
        :exchange_type => :direct,
        :hooks => {},
        :start_worker_delay => 2}

Sneakers.configure(config)

Sneakers.logger.level = Logger::INFO
