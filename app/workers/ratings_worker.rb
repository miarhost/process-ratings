
require 'sneakers'
class RatingsWorker
  include Sneakers::Worker
  #include MongoClient
  include SneakersLogging

  from_queue :predictions

  def work(payload)
    ratings_list = RatingsList.new
    ratings_list.result = JSON.parse(payload)
    ratings_list.received_at = Time.now
    ratings_list.save!
    ack!
  end
end
