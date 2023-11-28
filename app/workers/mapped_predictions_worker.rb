require 'sneakers'
class MappedPredictionsWorker
  include Sneakers::Worker
  include MongoClient

  from_queue :subscriptions_for_user

  def work(payload)
    UploadsInfoPrediction.create!(result: payload, received_at: DateTime.now)
    puts payload
    ack!
  end
end
