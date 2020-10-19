require 'rails_helper'

RSpec.describe Project, type: :model do
  let! (:project) { create(:project) }
  
  describe 'Project validation' do
    it 'allows valid title and description' do
      expect(project.valid?).to eq true
    end

    it 'allows project with no description' do
      project.description = ""
      expect(project.valid?).to eq true
    end
  end
end
