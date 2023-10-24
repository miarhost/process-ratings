require 'sneakers'
class BasicWorker
include Sneakers::Worker
  class << self

    def logging(payload, delivery_info)
      message = "Successfully delivered  at #{delivery_info[:routing_key]}:
      #{payload}"

      Sneakers::logger.error(message)
    end

    def error_messaging(e, metadata)
      message = "#{e} stopped delivering at #{delivery_info[:routing_key]}"

      Sneakers::logger.info(message)
    end
  end
end
