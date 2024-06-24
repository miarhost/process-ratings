require 'sneakers'
require 'sneakers/metrics/logging_metrics'

config = {
          vhost: '/',
          timeout_job_after: 5,
          prefetch:10,
          threads: 10,
          env: ENV['RACK_ENV'],
          durable: true,
          exchange_options: {
          type: 'direct',
          durable: true
          },
          queue_options:    {
            durable: true
          },
          ack: true,
          heartbeat: 1,
          exchange: 'snickers',
          exchange_type: :direct,
          hooks: {},
          workers: 7,
          start_worker_delay: 1,
          metrics: Sneakers::Metrics::LoggingMetrics.new,
          log: 'log/sneakers.log'
          #daemonize: true
        }

Sneakers.configure(config)

Sneakers.logger.level = Logger::INFO
