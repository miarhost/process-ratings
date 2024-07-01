require 'sneakers'
class TopicsList

  include Mongoid::Document
  include HooksHelpers
  field :document, type: Array
  field :urls, type: Array # urls parsed by income topics each have own lists or don't
  field :topics, type: Array
  field :parsed_at, type: DateTime
  field :rate, type: Integer # for existent
  field :user, type: Integer
  field :origin, type: String # existent or ollama

  after_create do |model|
    publish_payload(model)
  end

  protected

  def publish_payload(model)
    delivery_info = {routing_key: sneakers_config[:queue_name]}
    metadata = { content_type: 'application/json', delivery_mode: 2, priority: 2 }
    LinksPublisherWorker.new(sneakers_config[:queue_name], sneakers_config[:exchange])
      .work_with_params(model[:document].to_json, delivery_info, metadata)
  end

  def queue_name
    'parsed.links'
  end
end
