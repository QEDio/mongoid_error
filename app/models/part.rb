class Part
  include Mongoid::Document
  embedded_in :computer

  field :description1, type: Array
  field :description2

  field :dirty, type: Boolean
  field :active, type: Boolean
end