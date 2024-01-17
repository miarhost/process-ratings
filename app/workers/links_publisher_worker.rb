require 'sneakers'
require 'faraday'
class LinksPublisherWorker
  include Sneakers::Worker
  include SneakersLogging

  from_queue :parsing

  def work_with_params(data=ParsedList.last, delivery_info, metadata)
    publish(data, to_queue: 'parsing')
    worker_trace "sending links by request #{data}"
    logging(data, delivery_info, metadata)
  rescue => e
    error_messaging(e, delivery_info)
    ack!
  end
end
