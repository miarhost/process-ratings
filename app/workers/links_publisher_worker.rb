require 'sneakers'
class LinksPublisherWorker
  include Sneakers::Worker
  include SneakersLogging
  from_queue 'parsed.links'

  def work_with_params(message, delivery_info, metadata)
    self.class.enqueue(message, routing_key: , content_type: 'application/json', content_encoding: 'deflate', to_queue: routing_key)
    logging(message, delivery_info, metadata)
  rescue => e
    error_messaging(e.backtrace, delivery_info)
    ack!
  end

  def routing_key
    'parsed.links'
  end
end
