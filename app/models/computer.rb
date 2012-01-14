class Computer
  include Mongoid::Document
  embeds_many :parts
end