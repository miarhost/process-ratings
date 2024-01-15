class ImportanceList
  include Mongoid::Document
  field :values, type: Array
  field :received_at, type: DateTime
end
