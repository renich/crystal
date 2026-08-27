require "spec"
require "compiler/crystal/util"

describe Crystal do
  describe ".relative_filename" do
    it "returns the object if it is not a string" do
      Crystal.relative_filename(123).should eq(123)
      Crystal.relative_filename(nil).should eq(nil)
    end

    it "returns the relative filename if it starts with Dir.current and a separator" do
      sep = Path::SEPARATORS.first
      filename = "#{Dir.current}#{sep}foo#{sep}bar.cr"
      Crystal.relative_filename(filename).should eq("foo#{sep}bar.cr")
    end

    it "returns the chopped filename if it starts with Dir.current but no separator" do
      filename = "#{Dir.current}baz.cr"
      Crystal.relative_filename(filename).should eq("baz.cr")
    end

    it "returns the original filename if it does not start with Dir.current" do
      filename = "/tmp/foo/bar.cr"
      Crystal.relative_filename(filename).should eq("/tmp/foo/bar.cr")
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
