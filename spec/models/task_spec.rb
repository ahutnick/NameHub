require 'rails_helper'

RSpec.describe Task, type: :model do
  let! (:task) { create(:task) }
  
  describe "stages" do
    it 'must be in STAGES list' do
      task.stage = "banana"
      expect(task.valid?).to eq false
      task.stage = "ideas"
      expect(task.valid?).to eq false
    end
  end

  describe "Dependent destroy" do
    let (:comment) { create(:comment, task: task) }

    it 'deletes comments with task' do
      expect(comment.valid?).to eq true
      expect {
        task.destroy
      }.to change { Comment.count }.by(-1)
    end
  end
end
