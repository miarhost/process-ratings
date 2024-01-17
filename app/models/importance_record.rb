class ImportanceRecord
  include Mongoid::Document
  field :importance, type: Float
  field :item_id, type: Integer
  field :item_type, type: String
  field :received_at, type: DateTime
end
