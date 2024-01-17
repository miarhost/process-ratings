class ParsedRecord
  include Mongoid::Document
  field :url, type: String
  field :topic, type: String
  field :created_at, type: DateTime
end
