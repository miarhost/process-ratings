class RatingsList
  include Mongoid::Document
  field :result, type: Hash
  field :received_at, type: DateTime
end
