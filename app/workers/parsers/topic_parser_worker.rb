require 'sneakers'
require 'faraday'
class Parsers::TopicParserWorker < Parsers::LinkParserWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue 'parsing.topic', threads: 15, prefetch: 15, timeout_job_after: 1

  def work_with_params(message, delivery_info, metadata)
    data = JSON.parse(message)
    worker_trace "received #{data} at #{Time.now}"
    if data['topic']
      save_to_list_record(scrap(data),data)
    end
    logging(data, delivery_info, metadata)

  rescue => e
    error_messaging(e, delivery_info)
    ack!
  end

  def url(data)
    Links::EDU + data['topic'] + "/MostRecent"
  end

  def scrap(data)
    resource = Faraday.get(url(data))
    doc = Nokogiri::HTML(resource.body)
    links = []
    attrs = doc.css('div.download')
    attrs.each do |item|
      links << item.css("a").attribute("href").value
    end
    links
  end

  def save_to_list_record(links, data)
    TopicList.create!(
      document: links,
      main_url: url(data),
      parsed_at: Time.now,
      topic: data['topic'],
      rate: data['rate'],
      user: data['user']
    )
  end
end
