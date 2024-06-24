require 'sneakers'
require 'faraday'
class Parsers::TopicParserWorker
  include Sneakers::Worker
  include MongoClient
  include SneakersLogging

  from_queue 'parsing.topics', threads: 15, prefetch: 15, timeout_job_after: 1

  def work_with_params(message, delivery_info, metadata)
    data = JSON.parse(message)
    worker_trace "received #{data} at #{Time.now}"
    if payload_has_topics?(data)
      save_to_list_record(scrap(data), data)
    end
    logging(data, delivery_info, metadata)
    ack!

  rescue => e
    error_messaging(e, delivery_info)
  end

  def payload_has_topics?(data)
    data['topics'] != 'undefined' && data['subtopics']
  end

  def called_topics(data)
    data['topics'] != 'undefined' ? data['topics'] : data['subtopics']
  end


  def urls(topics)
    urls = []
    topics.each { |plus| urls << Links::EDU + plus + "/MostRecent" }
    urls
  end

  def scrap(data)
    resources = urls(called_topics(data))
    links = []
    resources.each do |page|
      resource = Faraday.get(page)
      doc = Nokogiri::HTML(resource.body)

      attrs = doc.css('div.download')
      attrs.each do |item|
        links << item.css("a").attribute("href").value
      end
    end
    links
  end

  def save_to_list_record(links, data)
    TopicsList.create!(
      document: links,
      urls: urls(called_topics(data)),
      topics: called_topics(data),
      parsed_at: Time.now,
      rate: data['rate'],
      user: data['user'],
      origin: data['origin']
    )
  end
end
