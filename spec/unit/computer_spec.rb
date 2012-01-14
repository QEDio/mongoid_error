require 'spec_helper'

describe Computer do
  let(:computer) do
    computer = Computer.new
    part = Part.new
    computer.parts << part
    computer.save
    computer
  end

  it "trips after setting the format (with type :array) more then once" do
    PART_DATA1 = ['abc', 'def']
    PART_DATA2 = ['xyz']

    # get part
    part = computer.parts.first
    # set data
    part.description1 = PART_DATA1
    # print, also ouput part objectid
    puts "#{part}: first setting: #{part.inspect}"
    # save
    part.save!

    # reload => correct data
    # get computer from database, otherwise the same part object will be returned when doing computer.parts.find(part.id)
    my_pc = Computer.find(computer.id)
    # get part, but different name
    part1 = my_pc.parts.find(part.id)
    # print, also ouput part objectid
    puts "#{part1}: reloaded first setting: #{part1.inspect}"
    # yup
    part1.description1.should == PART_DATA1

    # write new part data
    part1.description1 = PART_DATA2
    # print, also ouput part objectid
    puts "#{part1}: second setting: #{part1.inspect}"
    part1.save!

    # reload => wrong data
    # get computer from database, otherwise the same part object will be returned when doing computer.parts.find(part.id)
    my_pc = Computer.find(computer.id)
    # get part, but different name
    part2 = my_pc.parts.find(part.id)
    # aha, it's nil
    puts "#{part2}: reloaded second setting: #{part2.inspect}"

    # whaaaaaaaaaaaaaaaaat?
    part2.description1.should be_nil
    part2.description1.should == PART_DATA2
  end

  it "works when the field type is not set" do
    PART_DATA1 = ['abc', 'def']
    PART_DATA2 = ['xyz']

    # get part
    part = computer.parts.first
    # set data
    part.description2 = PART_DATA1
    # print, also ouput part objectid
    puts "#{part}: first setting: #{part.inspect}"
    # save
    part.save!

    # reload => correct data
    # get computer from database, otherwise the same part object will be returned when doing computer.parts.find(part.id)
    my_pc = Computer.find(computer.id)
    # get part, but different name
    part1 = my_pc.parts.find(part.id)
    # print, also ouput part objectid
    puts "#{part1}: reloaded first setting: #{part1.inspect}"
    # yup
    part1.description2.should == PART_DATA1

    # write new part data
    part1.description2 = PART_DATA2
    # print, also ouput part objectid
    puts "#{part1}: second setting: #{part1.inspect}"
    part1.save!

    # reload => correct data
    # get computer from database, otherwise the same part object will be returned when doing computer.parts.find(part.id)
    my_pc = Computer.find(computer.id)
    # get part, but different name
    part2 = my_pc.parts.find(part.id)
    # looking good
    puts "#{part2}: reloaded second setting: #{part2.inspect}"

    
    part2.description2.should_not be_nil
    part2.description2.should == PART_DATA2
  end
end