require "spec"
require "compiler/crystal/tools/git"

describe Crystal::Git do
  describe ".git_command" do
    it "returns true on success" do
      original = Crystal::Git.executable
      begin
        Crystal::Git.executable = "true"
        Crystal::Git.git_command([] of String).should eq(true)
      ensure
        Crystal::Git.executable = original
      end
    end

    it "returns false on failure" do
      original = Crystal::Git.executable
      begin
        Crystal::Git.executable = "false"
        Crystal::Git.git_command([] of String).should eq(false)
      ensure
        Crystal::Git.executable = original
      end
    end

    it "returns false if executable is missing" do
      original = Crystal::Git.executable
      begin
        Crystal::Git.executable = "nonexistent_executable_123"
        Crystal::Git.git_command([] of String).should eq(false)
      ensure
        Crystal::Git.executable = original
      end
    end
  end

  describe ".git_capture" do
    it "returns captured output on success" do
      original = Crystal::Git.executable
      begin
        Crystal::Git.executable = "echo"
        Crystal::Git.git_capture(["hello"]).should eq("hello\n")
      ensure
        Crystal::Git.executable = original
      end
    end

    it "returns nil on failure" do
      original = Crystal::Git.executable
      begin
        Crystal::Git.executable = "false"
        Crystal::Git.git_capture([] of String).should eq(nil)
      ensure
        Crystal::Git.executable = original
      end
    end
  end

  describe ".git_config" do
    it "returns config value" do
      original = Crystal::Git.executable
      begin
        Crystal::Git.executable = "echo"
        Crystal::Git.git_config("user.name").should eq("config --get user.name")
      ensure
        Crystal::Git.executable = original
      end
    end

    it "returns nil on failure" do
      original = Crystal::Git.executable
      begin
        Crystal::Git.executable = "false"
        Crystal::Git.git_config("user.name").should eq(nil)
      ensure
        Crystal::Git.executable = original
      end
    end
  end
end
