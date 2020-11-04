require 'rails_helper'

RSpec.describe Comment, type: :model do
  let (:comment) { create(:comment) }

  describe 'validation' do
    it 'rejects blank comments' do
      comment.content = ""
      expect(comment.valid?).to eq false
    end
  end
end
