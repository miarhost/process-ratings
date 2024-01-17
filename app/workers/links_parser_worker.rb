require 'sneakers'
require 'faraday'
class LinksParserWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue :parsing

  def work_with_params(data, delivery_info, metadata)
    worker_trace "received #{data} at #{Time.now}"
    save_to_list_record(scrap(data), data[:url], data[:topic])
    logging(data, delivery_info, metadata)
  rescue => e
    error_messaging(e, delivery_info)
    ack!
  end

  def scrap(data)
    resource = Faraday.get(data[:url])
    puts resource.body
    doc = Nokogiri::HTML(open(resource.body))
    doc.css('a href')
      .select { |i| i['class'] == "u-tcGrayDarkest js-work-link" }
  end

  def save_to_list_record(links, url, topic)
    ParsedList.create!(
      document: links,
      main_url: url,
      parsed_at: Time.now,
      topic: topic
    )
  end
end
