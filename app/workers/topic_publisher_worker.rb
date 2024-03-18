require 'sneakers'
class TopicPublisherWorker < LinksPublisherWorker
  def data
    TopicList.last.document
  end

  def queue
    'parsed.topics'
  end
end
