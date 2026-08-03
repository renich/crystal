require "spec"
require "compiler/crystal/util"

describe Crystal do
  describe ".with_line_numbers" do
    it "formats a string with line numbers" do
      source = "foo\nbar\nbaz"
      expected = "   1 | foo\n   2 | bar\n   3 | baz"
      Crystal.with_line_numbers(source).should eq(expected)
    end

    it "formats with a target line" do
      source = "foo\nbar\nbaz"
      expected = "   1 | foo\n > 2 | bar\n   3 | baz"
      Crystal.with_line_numbers(source, highlight_line_number: 2).should eq(expected)
    end

    it "formats an array of strings" do
      source = ["foo", "bar"]
      expected = "   1 | foo\n   2 | bar"
      Crystal.with_line_numbers(source).should eq(expected)
    end

    it "starts at a specific line number" do
      source = "foo\nbar"
      expected = "   10 | foo\n   11 | bar"
      Crystal.with_line_numbers(source, line_number_start: 10).should eq(expected)
    end

    it "colors output" do
      source = "foo\nbar"
      Crystal.with_line_numbers(source, highlight_line_number: 2, color: true).should eq(
        " > 1 | ".colorize.dim.to_s + "foo\n" +
        " > 2 | ".colorize.green.to_s + "bar".colorize.bold.to_s
      )
    end
  end
end
