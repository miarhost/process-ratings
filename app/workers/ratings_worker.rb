
require 'sneakers'
class RatingsWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue :predictions

  def work(payload)
    config[:ratings_list].insert_one(payload)
    ratings_list = RatingsList.new
    ratings_list[:result] << payload[:result]
    ratings_list.save!
    ack!
  end
end
