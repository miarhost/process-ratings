class ParsedList
  include Mongoid::Document
  field :document, type: Array
  field :main_url, type: String
  field :parsed_at, type: DateTime
  field :topic, type: String
end
