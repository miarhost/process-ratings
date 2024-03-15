class TopicList
  include Mongoid::Document
  field :document, type: Array
  field :main_url, type: String
  field :parsed_at, type: DateTime
  field :topic, type: String
  field :rate, type: Integer
  field :user, type: Integer
end
