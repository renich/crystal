require "../../../spec_helper"
require "../../../../src/compiler/crystal/interpreter/repl_reader"
require "../../../../src/compiler/crystal/interpreter/pry_reader"

describe Crystal::ReplReader do
  it "flushes io in prompt" do
    io = IO::Memory.new
    reader = Crystal::ReplReader.new
    reader.prompt(io, 1, false)
    io.to_s.should eq "icr:1> "
  end
end

describe Crystal::PryReader do
  it "flushes io in prompt" do
    io = IO::Memory.new
    reader = Crystal::PryReader.new
    reader.prompt(io, 1, false)
    io.to_s.should eq "pry()> "
  end
end
