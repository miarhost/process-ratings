require 'sneakers'
class ParsedList
  include Mongoid::Document
  field :document, type: Array
  field :main_url, type: String
  field :parsed_at, type: DateTime
  field :topic, type: String

  after_create do |model|
    publish_payload(model)
  end

  protected

  def publish_payload(model)
    delivery_info = {routing_key: 'parsed.links'}
    metadata = { content_type: "application/octet-stream", delivery_mode: 2, priority: 0 }
    LinksPublisherWorker.new('parsed.links', 'snickers')
      .work_with_params(model[:document], delivery_info, metadata)
  end
end
