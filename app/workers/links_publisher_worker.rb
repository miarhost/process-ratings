require 'sneakers'
class LinksPublisherWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue 'parsed.links', threads: 11, prefetch: 11, timeout_job_after: 1


  def work_with_params(_message, delivery_info, metadata)
    publish(JSON.generate(data), to_queue: publish_queue, routing_key: publish_queue)
    worker_trace "sending links by request: #{data}"
    logging(data, delivery_info, metadata)
  rescue => e
    error_messaging(e.backtrace, delivery_info)
    ack!
  end

  def data
    ParsedList.last.document || []
  end

  def publish_queue
    'parsed.links'
  end
end
