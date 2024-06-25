require 'sneakers'
class LinksPublisherWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue 'parsed.links', threads: 11, prefetch: 11, timeout_job_after: 1


  def work_with_params(message, delivery_info, metadata)
    logging(message, delivery_info, metadata)
  rescue => e
    error_messaging(e.backtrace, delivery_info)
    ack!
  end

end
