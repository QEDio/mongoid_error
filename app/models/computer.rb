class Computer
  include Mongoid::Document
  field :dirty, type: Boolean
  field :active, type: Boolean
  embeds_many :parts
end