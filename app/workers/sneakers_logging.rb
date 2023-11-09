require 'sneakers'
module SneakersLogging
extend Sneakers::Worker

  def logging(payload, delivery_info)
    message = "Successfully delivered  at #{delivery_info[:routing_key]}:
    #{payload}"

    Sneakers::Logger.error(message)
  end

  def error_messaging(e, metadata)
    message = "#{e} stopped delivering at #{delivery_info[:routing_key]}"

    Sneakers::Logger.info(message)
  end
end
