require "../../spec_helper"

describe Crystal::SyntaxException do
  it "can be initialized and serialized to JSON" do
    ex = Crystal::SyntaxException.new("bad syntax", 10, 5, "foo.cr", 42)

    ex.has_location?.should be_truthy
    ex.line_number.should eq(10)
    ex.column_number.should eq(5)
    ex.filename.should eq("foo.cr")
    ex.size.should eq(42)

    json = ex.to_json

    # Using JSON.parse to verify structure
    parsed = JSON.parse(json)
    parsed.as_a.size.should eq(1)

    obj = parsed[0]
    obj["file"].should eq("foo.cr")
    obj["line"].should eq(10)
    obj["column"].should eq(5)
    obj["size"].should eq(42)
    obj["message"].should eq("bad syntax")
  end

  it "has default_message and deepest_error_message" do
    ex = Crystal::SyntaxException.new("bad syntax", 10, 5, "foo.cr", 42)
    ex.default_message.should eq("syntax error in foo.cr:10")
    ex.deepest_error_message.should eq("bad syntax")
  end

  it "has default_message as warning if warning property is set" do
    ex = Crystal::SyntaxException.new("bad syntax", 10, 5, "foo.cr", 42)
    ex.warning = true
    ex.default_message.should eq("warning in foo.cr:10")
  end

  it "has_location? returns truthy if line_number is present" do
    ex = Crystal::SyntaxException.new("bad syntax", 10, 5, nil, 42)
    ex.has_location?.should be_truthy
  end

  it "tests append_to_s format" do
    ex = Crystal::SyntaxException.new("bad syntax", 10, 5, "foo.cr", 42)
    io = String::Builder.new
    ex.append_to_s(io, nil)
    output = io.to_s
    output.should contain("syntax error in foo.cr:10")
    output.should contain("Error: bad syntax")
  end

  it "tests append_to_s format with warning" do
    ex = Crystal::SyntaxException.new("bad syntax", 10, 5, "foo.cr", 42)
    ex.warning = true
    io = String::Builder.new
    ex.append_to_s(io, nil)
    output = io.to_s
    output.should contain("warning in foo.cr:10")
    output.should contain("Warning: bad syntax")
  end

  it "tests append_to_s format with multiline message" do
    ex = Crystal::SyntaxException.new("bad syntax\nmore details", 10, 5, "foo.cr", 42)
    io = String::Builder.new
    ex.append_to_s(io, nil)
    output = io.to_s
    output.should contain("Error: bad syntax")
    output.should contain("more details")
  end

  it "tests to_s_with_source" do
    ex = Crystal::SyntaxException.new("bad syntax", 10, 5, "foo.cr", 42)
    io = String::Builder.new
    ex.to_s_with_source(io, nil)
    output = io.to_s
    output.should contain("syntax error in foo.cr:10")
    output.should contain("Error: bad syntax")
  end
end
