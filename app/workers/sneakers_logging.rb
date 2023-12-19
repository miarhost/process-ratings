require 'sneakers'
module SneakersLogging
extend Sneakers::Worker

  def logging(payload, delivery_info, metadata)
    message = "Successfully delivered  at #{delivery_info[:routing_key]}: \n
    payload: #{payload}. \n
    metadata: #{metadata}"

    Sneakers.logger.info(message)
  end

  def error_messaging(e, delivery_info)
    message = "#{e} stopped delivering at #{delivery_info[:routing_key]}"

    Sneakers.logger.error(message)
  end
end
