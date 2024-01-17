require 'sneakers'
  class ImportancesWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue :importances

  def work_with_params(payload, delivery_info, metadata)
    payload = JSON.parse(payload)
    ImportanceList.create!(
      values: payload,
      received_at: Time.now
    )
    payload.each do |pair|
      ImportanceRecord.create!(
        importance: pair['importance'],
        item_id: pair['item_id'],
        item_type: pair['item_type'],
        received_at: Time.now
      )
    end
    ack!
    logging(payload, delivery_info, metadata)
  rescue => e
    error_messaging(e, delivery_info)
  end
end
