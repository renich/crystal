require "./spec_helper"
require "../../src/compiler/crystal/warnings"

describe Crystal::WarningCollection do
  it "detects and reports warnings" do
    collection = Crystal::WarningCollection.new
    collection.infos.should be_empty
    collection.error_on_warnings?.should be_false

    node = Crystal::Var.new("foo")
    node.location = Crystal::Location.new("foo.cr", 1, 1)

    collection.add_warning(node, "warning message")
    collection.infos.size.should eq(1)

    io = IO::Memory.new
    collection.report(io)
    io.to_s.should contain("warning message")
    io.to_s.should contain("A total of 1 warnings were found.")
  end

  it "reports multiple warnings" do
    collection = Crystal::WarningCollection.new

    node1 = Crystal::Var.new("foo")
    node1.location = Crystal::Location.new("foo.cr", 1, 1)
    collection.add_warning(node1, "first warning")

    node2 = Crystal::Var.new("bar")
    node2.location = Crystal::Location.new("bar.cr", 1, 1)
    collection.add_warning(node2, "second warning")

    collection.infos.size.should eq(2)

    io = IO::Memory.new
    collection.report(io)
    io.to_s.should contain("first warning")
    io.to_s.should contain("second warning")
    io.to_s.should contain("A total of 2 warnings were found.")
  end

  it "ignores warnings based on location" do
    collection = Crystal::WarningCollection.new
    collection.exclude_path("ignored.cr")

    node = Crystal::Var.new("foo")
    node.location = Crystal::Location.new(File.expand_path("ignored.cr"), 1, 1)
    collection.add_warning(node, "warning message")

    collection.infos.should be_empty
  end

  it "ignores warnings for multiple paths" do
    collection = Crystal::WarningCollection.new
    collection.exclude_path("ignored1.cr")
    collection.exclude_path("ignored2.cr")

    node = Crystal::Var.new("foo")
    node.location = Crystal::Location.new(File.expand_path("ignored1.cr"), 1, 1)
    collection.add_warning(node, "warning message 1")

    node.location = Crystal::Location.new(File.expand_path("ignored2.cr"), 1, 1)
    collection.add_warning(node, "warning message 2")

    node.location = Crystal::Location.new("not_ignored.cr", 1, 1)
    collection.add_warning(node, "warning message 3")

    collection.infos.size.should eq(1)
    collection.infos.first.should contain("warning message 3")
  end

  it "ignores warnings in lib directory when exclude_lib_path is true" do
    collection = Crystal::WarningCollection.new
    collection.exclude_lib_path = true
    collection.exclude_lib_path?.should be_true

    node = Crystal::Var.new("foo")
    node.location = Crystal::Location.new(File.expand_path(Crystal.normalize_path("lib/foo.cr")), 1, 1)
    collection.add_warning(node, "warning message")

    collection.infos.should be_empty
  end

  it "does not ignore warnings in lib directory when exclude_lib_path is false" do
    collection = Crystal::WarningCollection.new
    collection.exclude_lib_path = false
    collection.exclude_lib_path?.should be_false

    node = Crystal::Var.new("foo")
    node.location = Crystal::Location.new(File.expand_path(Crystal.normalize_path("lib/foo.cr")), 1, 1)
    collection.add_warning(node, "warning message")

    collection.infos.size.should eq(1)
    collection.infos.first.should contain("warning message")
  end

  it "does not add warnings when level is none" do
    collection = Crystal::WarningCollection.new
    collection.level = Crystal::WarningLevel::None

    node = Crystal::Var.new("foo")
    node.location = Crystal::Location.new("foo.cr", 1, 1)
    collection.add_warning(node, "warning message")

    collection.infos.should be_empty
  end

  it "does not add warnings at location when level is none" do
    collection = Crystal::WarningCollection.new
    collection.level = Crystal::WarningLevel::None

    collection.add_warning_at(Crystal::Location.new("foo.cr", 1, 1), "warning at location")

    collection.infos.should be_empty
  end

  it "adds warnings at location" do
    collection = Crystal::WarningCollection.new
    collection.add_warning_at(Crystal::Location.new("foo.cr", 1, 1), "warning at location")
    collection.infos.size.should eq(1)
    collection.infos.first.should contain("warning at location")
  end

  it "adds warnings at nil location" do
    collection = Crystal::WarningCollection.new
    collection.add_warning_at(nil, "warning without location")
    collection.infos.size.should eq(1)
    collection.infos.first.should eq("warning without location")
  end

  it "returns false for ignore_warning_due_to_location? with nil location" do
    collection = Crystal::WarningCollection.new
    collection.ignore_warning_due_to_location?(nil).should be_false
  end

  it "returns false for ignore_warning_due_to_location? with no original filename" do
    collection = Crystal::WarningCollection.new
    macro_node = Crystal::Macro.new("foo", [] of Crystal::Arg, Crystal::Nop.new)
    virtual_file = Crystal::VirtualFile.new(macro_node, "source", nil)
    location = Crystal::Location.new(virtual_file, 1, 1)
    collection.ignore_warning_due_to_location?(location).should be_false
  end
end
