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

end
