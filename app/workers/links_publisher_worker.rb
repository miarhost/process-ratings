require 'sneakers'
class LinksPublisherWorker
  include Sneakers::Worker
  include SneakersLogging

  from_queue 'parsed.links', threads: 11, prefetch: 11, timeout_job_after: 1

  def work_with_params(message, delivery_info, metadata)
    encoded_msg = Sneakers::ContentType.serialize(message, 'application/json')
    Sneakers::Publisher.new(exchange: 'snickers', exchange_type: 'direct', heartbeat: 1)
                       .publish(encoded_msg, routing_key: 'parsed.links', content_type: 'application/json')
    logging(message, delivery_info, metadata)
  rescue => e
    error_messaging(e.backtrace, delivery_info)
    ack!
  end
end
