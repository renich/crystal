require "spec"

describe IO::Error do
  describe ".new" do
    it "sets message and target" do
      error = IO::Error.new("test message", target: "foo")
      error.message.should eq("test message")
      error.target.should eq("foo")
    end

    it "accepts cause argument" do
      cause = Exception.new("cause")
      error = IO::Error.new("foo", cause: cause)
      error.cause.should be cause
    end
  end

  describe ".from_os_error" do
    it "formats message with string target" do
      error = IO::Error.from_os_error("test", Errno.new(LibC::EINVAL), target: "foo")
      error.message.should eq("test (foo): Invalid argument")
      error.target.should eq("foo")
    end

    it "formats message with File target" do
      File.open(__FILE__) do |file|
        error = IO::Error.from_os_error("test", Errno.new(LibC::EINVAL), target: file)

        # IO::Error uses SystemError internally.
        # SystemError::ClassMethods#from_os_error passes **opts to build_message
        # and to Exception#initialize.
        # IO::Error#initialize takes `*, target = nil` and sets `@target = target.try(&.to_s)`.
        # When target is a File, file.to_s looks like `#<File:0x...>`
        # However, IO::Error.build_message has an overload for target: File that uses target.path.
        error.message.should eq("test (#{file.path}): Invalid argument")

        # We also need to check that error.target uses `#to_s` of the passed target,
        # which is what `IO::Error#initialize` sets it to.
        error.target.should eq(file.to_s)
      end
    end

    it "formats message with nil target" do
      error = IO::Error.from_os_error("test", Errno.new(LibC::EINVAL), target: nil)
      error.message.should eq("test: Invalid argument")
      error.target.should be_nil
    end
  end
end

describe IO::TimeoutError do
  it "inherits from IO::Error" do
    error = IO::TimeoutError.new("timeout")
    error.is_a?(IO::Error).should be_true
    error.message.should eq("timeout")
  end
end

describe IO::EOFError do
  it "has a default message" do
    IO::EOFError.new.message.should eq("End of file reached")
  end

  it "accepts a custom message" do
    IO::EOFError.new("foo").message.should eq("foo")
  end
end
