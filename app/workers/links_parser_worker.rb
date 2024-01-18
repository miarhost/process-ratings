require 'sneakers'
require 'faraday'
class LinksParserWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue :parsing, threads: 50, prefetch: 50, timeout_job_after: 1

  def work_with_params(message, delivery_info, metadata)
    data = JSON.parse(message)
    worker_trace "received #{data} at #{Time.now}"
    links_list = save_to_list_record(scrap(data), data["url"], data["topic"])
    logging(data, delivery_info, metadata)

  rescue => e
    error_messaging(e, delivery_info)
    ack!
  end

  def scrap(data)
    resource = Faraday.get(data["url"])
    doc = Nokogiri::HTML(resource.body)
    links = []
    attrs = doc.css('div.download')
    attrs.each do |item|
      links << item.css("a").attribute("href").value
    end
    links
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
