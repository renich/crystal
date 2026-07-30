require "spec"
require "compiler/crystal/util"

describe Crystal do
  describe "print_error" do
    it "prints error with default settings" do
      io = IO::Memory.new
      Crystal.print_error("foo", false, stderr: io)
      io.to_s.should eq("Error: foo\n")
    end

    it "prints error with color" do
      io = IO::Memory.new
      Crystal.print_error("foo", true, stderr: io)
      io.to_s.should eq("\e[31;1mError: \e[39;22m\e[1mfoo\e[22m\n")
    end

    it "prints error without leading 'Error:'" do
      io = IO::Memory.new
      Crystal.print_error("foo", false, stderr: io, leading_error: false)
      io.to_s.should eq("foo\n")
    end

    it "prints colored error without leading 'Error:'" do
      io = IO::Memory.new
      Crystal.print_error("foo", true, stderr: io, leading_error: false)
      io.to_s.should eq("\e[1mfoo\e[22m\n")
    end
  end

  describe "normalize_path" do
    sep = {{ flag?(:win32) ? "\\" : "/" }}

    it { Crystal.normalize_path("a").should eq ".#{sep}a" }
    it { Crystal.normalize_path("./a/b").should eq ".#{sep}a#{sep}b" }
    it { Crystal.normalize_path("../a/b").should eq ".#{sep}..#{sep}a#{sep}b" }
    it { Crystal.normalize_path("/foo/bar").should eq "#{sep}foo#{sep}bar" }

    {% if flag?(:win32) %}
      it { Crystal.normalize_path("C:\\foo\\bar").should eq "C:\\foo\\bar" }
      it { Crystal.normalize_path("C:foo\\bar").should eq "C:foo\\bar" }
      it { Crystal.normalize_path("\\foo\\bar").should eq "\\foo\\bar" }
      it { Crystal.normalize_path("foo\\bar").should eq ".\\foo\\bar" }
    {% end %}
  end
end
