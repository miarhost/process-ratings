
require 'sneakers'
class RatingsWorker < BasicWorker
  include MongoClient

  from_queue :predictions

  def work(payload)
    config[:ratings_list].insert_one(payload)
    ack!
  end
end
