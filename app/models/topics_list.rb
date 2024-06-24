require 'sneakers'
require 'sneakers/runner'
class TopicsList

  include Mongoid::Document
  field :document, type: Array
  field :urls, type: Array
  field :topics, type: Array
  field :parsed_at, type: DateTime
  field :rate, type: Integer
  field :user, type: Integer
  field :origin, type: String

  after_create :publish_payload

  def publish_payload
    Sneakers::Runner.new([ TopicPublisherWorker ])
  end
end
