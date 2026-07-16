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
    it "formats lines without color by default" do
      Crystal.with_line_numbers("foo\nbar").should eq "   1 | foo\n   2 | bar"
    end

    it "accepts array of strings" do
      Crystal.with_line_numbers(["foo", "bar"]).should eq "   1 | foo\n   2 | bar"
    end

    it "starts with a custom line number and formats padding correctly" do
      Crystal.with_line_numbers("a\nb", line_number_start: 9).should eq "    9 | a\n   10 | b"
    end

    it "highlights a target line without color" do
      Crystal.with_line_numbers("a\nb\nc", highlight_line_number: 2).should eq "   1 | a\n > 2 | b\n   3 | c"
    end

    it "highlights a target line with color" do
      # Note: with color=true, all lines receive the "> " prefix and are colorized
      was_enabled = Colorize.enabled?
      Colorize.enabled = true
      begin
        Crystal.with_line_numbers("a\nb\nc", highlight_line_number: 2, color: true).should eq "\e[2m > 1 | \e[22ma\n\e[32m > 2 | \e[39m\e[1mb\e[22m\n\e[2m > 3 | \e[22mc"
      ensure
        Colorize.enabled = was_enabled
      end
    end

    it "formats without highlight but with color" do
      was_enabled = Colorize.enabled?
      Colorize.enabled = true
      begin
        Crystal.with_line_numbers("a\nb", color: true).should eq "\e[2m > 1 | \e[22ma\n\e[2m > 2 | \e[22mb"
      ensure
        Colorize.enabled = was_enabled
      end
    end
  end
end
