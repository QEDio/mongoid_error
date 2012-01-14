Mongoid Error with embedded_in and type: Array
========================

When embedding a document within another, and declaring a field within the embedded document as type: Array, setting this
field fails after the first time.

Please have a look at 'spec/computer_spec.rb'

Run the spec with: rake

What?
----------------
    
    class Computer
      include Mongoid::Document
      embeds_many :parts
    end

    class Part
      include Mongoid::Document
      embedded_in :computer

      field :description1, type: Array
      field :description2
    end

This fails:
--------------------------
    computer = Computer.new
    part = Part.new

    computer.parts << part
    computer.save

    part.description1 = PART_DATA1
    part.save

    part.description1 = PART_DATA2
    part.save

==> now part.description1 is null (in the db)
