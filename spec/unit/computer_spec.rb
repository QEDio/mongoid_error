  require 'spec_helper'

  describe Computer do
    describe 'preparing boolean values in embedded documents and saving them in another loop' do
      before do
        Computer.destroy_all

        [].tap do |arr|
          10.times do |i|
            c = Computer.new(active: false, dirty: true)
            c.parts << Part.new(active: false, dirty: true)
            c.parts << Part.new(active: false, dirty: true)
            c.save
            arr << c
          end
        end
      end

      it "doesn't store the values when setting values in one loop and doing the saving in another" do
        computers = Computer.all

        computers.each do |c|
          c.active.should be_false
          c.dirty.should be_true

          c.parts.each do |p|
            p.active.should be_false
            p.dirty.should be_true
          end
        end

        computers.each do |c|
          c.parts.each do |p|
            p.active = true
            p.dirty = false
          end
          c.active = true
          c.dirty = false
        end

        computers.each do |c|
          c.save
        end

        computers.each{|c|c.reload}

        computers.each do |c|
          c.active.should be_true
          c.dirty.should be_false

          c.parts.each do |p|
            p.active.should be_true
            p.dirty.should be_false
          end
        end
      end
    end

  #  describe 'saving embedded documents with arrays' do
  #  let(:computer) do
  #    computer = Computer.new
  #    part = Part.new
  #    computer.parts << part
  #    computer.save
  #    computer
  #  end
  #
  #  it "trips after setting the format (with type :array) more then once" do
  #    PART_DATA1 = ['abc', 'def']
  #    PART_DATA2 = ['xyz']
  #
  #    # get part
  #    part = computer.parts.first
  #    # set data
  #    part.description1 = PART_DATA1
  #    # print, also ouput part objectid
  #    #puts "#{part}: first setting: #{part.inspect}"
  #    # save
  #    part.save!
  #
  #    # reload => correct data
  #    # get computer from database, otherwise the same part object will be returned when doing computer.parts.find(part.id)
  #    my_pc = Computer.find(computer.id)
  #    # get part, but different name
  #    part1 = my_pc.parts.find(part.id)
  #    # print, also ouput part objectid
  #    #puts "#{part1}: reloaded first setting: #{part1.inspect}"
  #    # yup
  #    part1.description1.should == PART_DATA1
  #
  #    # write new part data
  #    part1.description1 = PART_DATA2
  #    # print, also ouput part objectid
  #    #puts "#{part1}: second setting: #{part1.inspect}"
  #    part1.save!
  #
  #    # reload => wrong data
  #    # get computer from database, otherwise the same part object will be returned when doing computer.parts.find(part.id)
  #    my_pc = Computer.find(computer.id)
  #    # get part, but different name
  #    part2 = my_pc.parts.find(part.id)
  #    # aha, it's nil
  #    #puts "#{part2}: reloaded second setting: #{part2.inspect}"
  #
  #    # whaaaaaaaaaaaaaaaaat?
  #    part2.description1.should_not be_nil
  #    part2.description1.should == PART_DATA2
  #  end
  #
  #  it "works when the field type is not set" do
  #    PART_DATA1 = ['abc', 'def']
  #    PART_DATA2 = ['xyz']
  #
  #    # get part
  #    part = computer.parts.first
  #    # set data
  #    part.description2 = PART_DATA1
  #    # print, also ouput part objectid
  #    #puts "#{part}: first setting: #{part.inspect}"
  #    # save
  #    part.save!
  #
  #    # reload => correct data
  #    # get computer from database, otherwise the same part object will be returned when doing computer.parts.find(part.id)
  #    my_pc = Computer.find(computer.id)
  #    # get part, but different name
  #    part1 = my_pc.parts.find(part.id)
  #    # print, also ouput part objectid
  #    #puts "#{part1}: reloaded first setting: #{part1.inspect}"
  #    # yup
  #    part1.description2.should == PART_DATA1
  #
  #    # write new part data
  #    part1.description2 = PART_DATA2
  #    # print, also ouput part objectid
  #    #puts "#{part1}: second setting: #{part1.inspect}"
  #    part1.save!
  #
  #    # reload => correct data
  #    # get computer from database, otherwise the same part object will be returned when doing computer.parts.find(part.id)
  #    my_pc = Computer.find(computer.id)
  #    # get part, but different name
  #    part2 = my_pc.parts.find(part.id)
  #    # looking good
  #    #puts "#{part2}: reloaded second setting: #{part2.inspect}"
  #
  #    part2.description2.should_not be_nil
  #    part2.description2.should == PART_DATA2
  #  end
  #end
end