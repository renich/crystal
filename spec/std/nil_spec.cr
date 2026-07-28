require "spec"

describe Nil do
  it "has object_id 0" do
    nil.object_id.should eq(0_u64)
  end

  it "is equal to nil" do
    (nil == nil).should be_true
  end

  it "is same as nil" do
    nil.same?(nil).should be_true
  end

  it "is not same as a reference" do
    nil.same?(String.new).should be_false
  end

  it "has a consistent hash" do
    hasher = Crystal::Hasher.new
    nil.hash(hasher).result.should eq(hasher.nil.result)
  end

  it "returns an empty string on to_s" do
    nil.to_s.should eq("")
  end

  it "does not write to IO on to_s(IO)" do
    io = IO::Memory.new
    nil.to_s(io)
    io.to_s.should eq("")
  end

  it "returns 'nil' on inspect" do
    nil.inspect.should eq("nil")
  end

  it "writes 'nil' to IO on inspect(IO)" do
    io = IO::Memory.new
    nil.inspect(io)
    io.to_s.should eq("nil")
  end

  it "returns self on try without yielding" do
    yielded = false
    result = nil.try { yielded = true }
    yielded.should be_false
    result.should be_nil
  end

  it "raises NilAssertionError on not_nil!" do
    expect_raises(NilAssertionError) do
      nil.not_nil!
    end
  end

  it "raises NilAssertionError with custom message on not_nil!" do
    expect_raises(NilAssertionError, "custom message") do
      nil.not_nil!("custom message")
    end
  end

  it "returns nil on presence" do
    nil.presence.should be_nil
  end

  it "returns nil on clone" do
    nil.clone.should be_nil
  end
end
