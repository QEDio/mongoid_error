class Prepare
  include Mongoid::Document

  field :dirty, type: Boolean
  field :active, type: Boolean
end