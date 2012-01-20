Object-Data getting lost
========================

When iterating with a cursor over a set of Mongoid Documents, the changes to those objects are lost outside the loop.
Is this the expected behaviour?

Please have a look at 'spec/computer_spec.rb'

Run the spec with: rake

What?
----------------
    class Computer
      include Mongoid::Document
      field :active, type: Boolean
      field :dirty, type: Boolean
    end

This fails:
--------------------------
     computers = Computer.all
     # computers = Computer.all.to_a fixes the problem

     computers.each do |c|
       c.active = true
       c.dirty = false
     end

     computers.each do |c|
       c.save
     end

     # nothing gets updated