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

    it 'rejects duplicate projects' do
      project_clone = project.dup
      project.save
      expect(project_clone.valid?).to eq false
    end

    it 'allows same descriptions' do 
      @project_2 =  Project.new(title: 'ljklj', description: project.description, user_id: project.user_id)
      expect(@project_2.valid?).to eq true
    end
  end

  describe 'Dependent destroy' do
    let(:task) { create(:task, project: project) }

    it 'deletes projects with user' do
      expect(task.valid?).to eq true
      expect { 
        project.destroy
      }.to change { Task.count }.by(-1)
    end
  end
end
