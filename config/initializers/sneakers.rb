require 'sneakers'
require 'sneakers/metrics/logging_metrics'

if Rails.env.test?

  config = {
          vhost: '/',
          timeout_job_after: 1,
          prefetch: 2,
          threads: 4,
          durable: true,
          exchange_options: {
          type: 'direct',
          durable: true
          },
          env: 'test',
          queue_options: {
            durable: true,
            queue_name: 'test_queue'
          },
          ack: true,
          heartbeat: 1,
          exchange: 'test',
          exchange_type: :direct,
          hooks: {},
          workers: 7,
          start_worker_delay: 1,
          metrics: Sneakers::Metrics::LoggingMetrics.new,
          log: 'log/sneakers_test.log'
        }
else

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
        }
end
Sneakers.configure(config)

Sneakers.logger.level = Logger::INFO
