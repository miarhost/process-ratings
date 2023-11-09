
require 'sneakers'
class RatingsWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue :predictions

  def work(payload)
    config[:ratings_list].insert_one(payload)
    ack!
  end
end
