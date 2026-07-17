require "spec"
require "../../src/compiler/crystal/progress_tracker"

describe Crystal::ProgressTracker do
  it "initializes with correct defaults" do
    tracker = Crystal::ProgressTracker.new
    tracker.stats?.should be_false
    tracker.progress?.should be_false
    tracker.current_stage.should eq 1
    tracker.current_stage_name.should be_nil
    tracker.stage_progress.should eq 0
    tracker.stage_progress_total.should be_nil
  end

  it "advances stages correctly" do
    tracker = Crystal::ProgressTracker.new

    result = tracker.stage("Stage 1") do
      tracker.current_stage_name.should eq "Stage 1"
      tracker.current_stage.should eq 1
      "result"
    end

    result.should eq "result"
    tracker.current_stage.should eq 2
    tracker.stage_progress.should eq 0
    tracker.stage_progress_total.should be_nil
  end

  it "allows setting progress" do
    tracker = Crystal::ProgressTracker.new
    tracker.stage_progress_total = 10
    tracker.stage_progress = 5

    tracker.stage_progress_total.should eq 10
    tracker.stage_progress.should eq 5
  end
end
