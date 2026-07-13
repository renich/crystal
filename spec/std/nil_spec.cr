require "spec"

describe Nil do
  it "returns object_id 0" do
    nil.object_id.should eq(0_u64)
  end

  it "is equal to itself" do
    (nil == nil).should be_true
  end

  it "is same as itself" do
    nil.same?(nil).should be_true
  end

  it "is not same as a reference" do
    nil.same?(Reference.new).should be_false
  end

  it "hashes consistently" do
    nil.hash.should eq(nil.hash)
  end

  it "to_s is empty string" do
    nil.to_s.should eq("")
  end

  it "to_s with IO writes nothing" do
    io = IO::Memory.new
    nil.to_s(io)
    io.to_s.should eq("")
  end

  it "inspect is 'nil'" do
    nil.inspect.should eq("nil")
  end

  it "inspect with IO writes 'nil'" do
    io = IO::Memory.new
    nil.inspect(io)
    io.to_s.should eq("nil")
  end

  it "try doesn't yield and returns nil" do
    yielded = false
    result = nil.try { yielded = true; 1 }
    yielded.should be_false
    result.should be_nil
  end

  it "not_nil! raises NilAssertionError" do
    expect_raises(NilAssertionError, "Nil assertion failed") do
      nil.not_nil!
    end
  end

  it "not_nil! with message raises NilAssertionError with that message" do
    expect_raises(NilAssertionError, "custom message") do
      nil.not_nil!("custom message")
    end
  end

  it "presence returns nil" do
    nil.presence.should be_nil
  end

  it "clone returns nil" do
    nil.clone.should be_nil
  end
end
