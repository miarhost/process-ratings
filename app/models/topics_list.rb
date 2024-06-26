require 'sneakers'
class TopicsList

  include Mongoid::Document
  field :document, type: Array
  field :urls, type: Array
  field :topics, type: Array
  field :parsed_at, type: DateTime
  field :rate, type: Integer
  field :user, type: Integer
  field :origin, type: String

  after_create do |model|
    publish_payload(model)
  end

  protected

  def publish_payload(model)
    delivery_info = {routing_key: 'parsed.links'}
    metadata = { content_type: 'application/json', delivery_mode: 2, priority: 2 }
    LinksPublisherWorker.new('parsed.links', 'snickers')
      .work_with_params(model[:urls].to_json, delivery_info, metadata)
  end
end
