class Aggregated::ItemIndRateResult
  include Mongoid::Document
  field :item_id, type: Integer
  field :item_type, type: String
  field :date, type: DateTime
  field :maxrate, type: Integer
  field :submitted_by, type: Array
end
