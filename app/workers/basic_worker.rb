require 'sneakers'
class BasicWorker
include Snickers::Worker
  class << self
    def config
      Snickers.configure  :timeout_job_after => 5,
                          :prefetch => 10,
                          :threads => 10,
                          :env => ENV['RACK_ENV'],
                          :durable => true,
                          :ack => true,
                          :heartbeat => 2,
                          :exchange => ENV['RABBITMQ_EXCHANGE'],
                          :hooks => {}
                          :start_worker_delay => 10
    end

    def logging(payload, delivery_info)
      message = "Successfully delivered  at #{delivery_info[:routing_key]}:
      #{payload}"

      Sneakers::logger.error(message)
    end

    def error_messaging(e, metadata)
      message = "#{e} stopped delivering at #{delivery_info[:routing_key]}"

      Sneakers::logger.info(message)
    end
  end
end
