require 'sneakers'
require 'faraday'
class LinksPublisherWorker
  include Sneakers::Worker
  include SneakersLogging

  from_queue :parsing, threads: 25, prefetch: 25, timeout_job_after: 1

  def work_with_params(data=ParsedList.last.document, delivery_info, metadata)
    publish(data.to_json, to_queue: 'parsed')
    worker_trace "sending links by request: #{data}"
    logging(data, delivery_info, metadata)
  rescue => e
    error_messaging(e, delivery_info)
    ack!
  end
end
