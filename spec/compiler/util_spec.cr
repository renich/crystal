require "spec"
require "compiler/crystal/util"

describe Crystal do
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

  describe "with_line_numbers" do
    it "formats string with line numbers" do
      Crystal.with_line_numbers("foo\nbar").should eq "   1 | foo\n   2 | bar"
    end

    it "formats array with line numbers" do
      Crystal.with_line_numbers(["foo", "bar"]).should eq "   1 | foo\n   2 | bar"
    end

    it "highlights line number" do
      Crystal.with_line_numbers("foo\nbar", highlight_line_number: 2).should eq "   1 | foo\n > 2 | bar"
    end

    it "starts at specific line number and pads correctly" do
      Crystal.with_line_numbers(["foo", "bar"], line_number_start: 9).should eq "    9 | foo\n   10 | bar"
    end
  end
end
