require 'sneakers'
class IndRatesCollectWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue :weekly_ind_rates

  def work_with_params(payload, delivery_info, metadata)
    collection = JSON.parse(payload)
    collection.each do |key, value|
      rate = UploadUserRate.new
      rate.value = value
      rate.received_at = Time.now
      rate.save!
    end
    ack!
    logging(payload, delivery_info, metadata)
  rescue => e
    error_messaging(e, delivery_info)
  end
end
