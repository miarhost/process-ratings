require 'sneakers'
class TopicPublisherWorker < LinksPublisherWorker
  from_queue 'parsed.topics', threads: 11, prefetch: 11, timeout_job_after: 1
  def data
    TopicsList.last.document
  end

  def publish_queue
    'parsed.topics'
  end
end
