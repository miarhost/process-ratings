class TopicList
  include Mongoid::Document
  field :document, type: Array
  field :urls, type: Array
  field :topics, type: Array
  field :parsed_at, type: DateTime
  field :rate, type: Integer
  field :user, type: Integer
  field :origin, type: String
end
