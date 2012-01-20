require 'spec_helper'

describe Prepare do
  let(:prepare) {Prepare.create(active: false, dirty: true)}

  it "doesn't save to db outside of loop" do
    prepare.reload
    prepare.active.should be_false
    prepare.dirty.should be_true

    [prepare].each do |p|
      p.active = true
      p.dirty = false
    end

    [prepare].each do |p|
      p.save
    end

    prepare.reload

    prepare.active.should be_true
    prepare.dirty.should be_false
  end
end