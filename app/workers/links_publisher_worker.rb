require 'sneakers'
require 'faraday'
class LinksPublisherWorker
  include Sneakers::Worker
  include SneakersLogging

  from_queue :parsed, threads: 25, prefetch: 25, timeout_job_after: 1

  def work_with_params(_message, delivery_info, metadata)
    data = ParsedList.last.document.take(5)
    publish(JSON.generate(data), to_queue: 'parsed', routing_key: 'parsed')
    worker_trace "sending links by request: #{data}"
    logging(data, delivery_info, metadata)
  rescue => e
    error_messaging(e.backtrace, delivery_info)
    ack!
  end
end
