require "spec"
require "http/content"

describe HTTP::Content do
  describe "#expects_continue=" do
    it "writes 100 Continue to IO upon first read if expects_continue is true" do
      io = IO::Memory.new
      content = HTTP::UnknownLengthContent.new(io)
      content.expects_continue = true

      content.read_byte

      io.to_s.should eq "HTTP/1.1 100 Continue\r\n\r\n"
    end

    it "writes 100 Continue only once" do
      io = IO::Memory.new
      content = HTTP::UnknownLengthContent.new(io)
      content.expects_continue = true

      content.read_byte
      content.read_byte

      io.to_s.should eq "HTTP/1.1 100 Continue\r\n\r\n"
    end

    it "does not write 100 Continue if expects_continue is false" do
      io = IO::Memory.new
      content = HTTP::UnknownLengthContent.new(io)
      content.expects_continue = false

      content.read_byte

      io.to_s.should eq ""
    end
  end

  describe "#close" do
    it "resets expects_continue to false and closes" do
      io = IO::Memory.new("hello")
      content = HTTP::FixedLengthContent.new(io, 3)
      content.expects_continue = true
      content.close

      expect_raises(IO::Error, "Closed stream") do
        content.read_byte
      end
    end
  end
end

describe HTTP::UnknownLengthContent do
  describe "#read" do
    it "reads from io" do
      io = IO::Memory.new("hello")
      content = HTTP::UnknownLengthContent.new(io)

      bytes = Bytes.new(5)
      content.read(bytes).should eq 5
      String.new(bytes).should eq "hello"
    end
  end

  describe "#read_byte" do
    it "reads a byte" do
      io = IO::Memory.new("h")
      content = HTTP::UnknownLengthContent.new(io)
      content.read_byte.should eq 'h'.ord
    end
  end

  describe "#peek" do
    it "peeks at io" do
      io = IO::Memory.new("hello")
      content = HTTP::UnknownLengthContent.new(io)
      peek = content.peek
      peek.should_not be_nil
      String.new(peek.not_nil!).should eq "hello"
    end
  end

  describe "#skip" do
    it "skips bytes" do
      io = IO::Memory.new("hello")
      content = HTTP::UnknownLengthContent.new(io)
      content.skip(2)
      content.gets_to_end.should eq "llo"
    end
  end

  describe "#write" do
    it "raises error" do
      io = IO::Memory.new("hello")
      content = HTTP::UnknownLengthContent.new(io)
      expect_raises(IO::Error, "Can't write to UnknownLengthContent") do
        content.write("test".to_slice)
      end
    end
  end
end

describe HTTP::FixedLengthContent do
  describe "#read" do
    it "reads from io" do
      io = IO::Memory.new("hello")
      content = HTTP::FixedLengthContent.new(io, 3)

      bytes = Bytes.new(5)
      content.read(bytes).should eq 3
      String.new(bytes[0, 3]).should eq "hel"
    end
  end

  describe "#read_byte" do
    it "reads a byte" do
      io = IO::Memory.new("hello")
      content = HTTP::FixedLengthContent.new(io, 3)
      content.read_byte.should eq 'h'.ord
    end

    it "returns nil at end of size" do
      io = IO::Memory.new("hello")
      content = HTTP::FixedLengthContent.new(io, 1)
      content.read_byte.should eq 'h'.ord
      content.read_byte.should be_nil
    end
  end

  describe "#peek" do
    it "peeks at io up to size limit" do
      io = IO::Memory.new("hello")
      content = HTTP::FixedLengthContent.new(io, 3)
      peek = content.peek
      peek.should_not be_nil
      String.new(peek.not_nil!).should eq "hel"
    end
  end

  describe "#skip" do
    it "skips bytes" do
      io = IO::Memory.new("hello")
      content = HTTP::FixedLengthContent.new(io, 4)
      content.skip(2)
      content.gets_to_end.should eq "ll"
    end
  end

  describe "#write" do
    it "raises error" do
      io = IO::Memory.new("hello")
      content = HTTP::FixedLengthContent.new(io, 3)
      expect_raises(IO::Error, "Can't write to FixedLengthContent") do
        content.write("test".to_slice)
      end
    end
  end
end
