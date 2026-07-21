require "spec"

describe Nil do
  it "object_id is 0" do
    nil.object_id.should eq(0_u64)
  end

  it "crystal_type_id" do
    nil.crystal_type_id.should eq(0)
  end

  it "==" do
    (nil == nil).should be_true
  end

  it "same?" do
    nil.same?(nil).should be_true
  end

  it "same? for Reference" do
    nil.same?(String.new).should be_false
  end

  it "hash" do
    hasher = Crystal::Hasher.new
    nil.hash(hasher).result.should eq(hasher.nil.result)
  end

  it "to_s" do
    nil.to_s.should eq("")
  end

  it "to_s with io" do
    io = IO::Memory.new
    nil.to_s(io)
    io.to_s.should eq("")
  end

  it "inspect" do
    nil.inspect.should eq("nil")
  end

  it "inspect with io" do
    io = IO::Memory.new
    nil.inspect(io)
    io.to_s.should eq("nil")
  end

  it "try" do
    nil.try { 1 }.should be_nil
  end

  it "not_nil!" do
    expect_raises(NilAssertionError) do
      nil.not_nil!
    end

    expect_raises(NilAssertionError, "custom message") do
      nil.not_nil!("custom message")
    end
  end

  it "presence" do
    nil.presence.should be_nil
  end

  it "clone" do
    nil.clone.should be_nil
  end
end
