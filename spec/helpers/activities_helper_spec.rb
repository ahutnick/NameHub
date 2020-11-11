require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

RSpec.describe ActivitiesHelper, type: :helper do
  let (:user) { create(:user) }
  let (:project) { create(:project, user: user) }
  let (:task) { create(:task, project: project) }
  let (:comment) { create(:comment, task: task) }

  before(:each) do
    sign_in(user)
  end

  describe "recent_activity" do
    it "returns ten actions" do
      create_list(:activity, 11, user: user, trackable: project)
      expect(recent_activity.count).to eq 10
    end

    it "sorts in descending order" do
      @activity1 = create(:activity, user: user, trackable: project)
      @activity2 = create(:activity, user: user, trackable: project)
      expect(recent_activity[0].created_at > recent_activity[1].created_at).to eq true
    end
  end

  describe "content_type" do
    it "returns content for comments" do
      @activity = create(:activity, user: user, trackable: comment)
      expect(content_type(@activity)).to eq(': ' + comment.content)
    end

    it 'returns title for projects' do
      @activity = create(:activity, user: user, trackable: project)
      expect(content_type(@activity)).to eq(': ' + project.title)
    end

    it 'returns title for tasks' do
      @activity = create(:activity, user: user, trackable: task)
      expect(content_type(@activity)).to eq(': ' + task.title)
    end

    it 'returns nil for destroy' do 
      @activity = create(:activity, user: user, trackable: comment, action: 'destroy')
      expect(content_type(@activity).nil?).to eq true
    end
  end

  describe "action_ed" do
    it 'returns Deleted for destroy' do
      @activity = create(:activity, user: user, trackable: comment, action: 'destroy')
      expect(action_ed(@activity)).to eq('Deleted')
    end

    it 'returns adds d to action ending in e' do
      @activity = create(:activity, user: user, trackable: comment, action: 'create')
      expect(action_ed(@activity)).to eq('Created')
    end
  end
end
