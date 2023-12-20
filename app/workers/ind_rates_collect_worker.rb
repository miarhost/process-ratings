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
      rate.payload = value
      rate.received_at = Time.now
      rate.user_id = value['user'][0].to_i
      rate.item_id = value['upload'][0].to_i
      rate.value = value['rate'][0].to_i
      rate.item_type = value.keys[0].capitalize
      rate.save!
    end
    ack!
    logging(payload, delivery_info, metadata)
  rescue => e
    error_messaging(e, delivery_info)
  end
end
