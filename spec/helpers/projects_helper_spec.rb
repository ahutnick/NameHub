require 'rails_helper'

RSpec.describe ProjectsHelper, type: :helper do
  let(:task) { create(:task) }
  let(:task2) { create(:task, project: task.project) }
  
  describe "progress" do
    it "properly uses percent, total, completed" do
      task2.stage = "completed"
      task2.save
      expect(helper.progress).to eq("1 / 2 Completed ( 50% )")
      task.stage = "completed"
      task.save
      expect(helper.progress).to eq("2 / 2 Completed ( 100% )")
    end
  end

  describe "completed?" do
    it "identifies completed projects" do
      task2.stage = "completed"
      task2.save
      expect(helper.completed?).to eq false
      task.stage = "completed"
      task.save
      expect(helper.completed?).to eq true
    end
  end
end
