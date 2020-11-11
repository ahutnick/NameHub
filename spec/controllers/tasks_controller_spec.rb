# == Schema Information
#
# Table name: tasks
#
# id                         :integer
# title                      :string
# stage                      :string
# description                :text
# project_id
#

require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

describe TasksController, type: :controller do
    let (:project) { create(:project) }

    before(:each) do
        @user = project.user
        sign_in(@user)
    end

    describe 'POST create' do
        it 'adds activity' do
            expect {
                post :create, params: { project_id: project.id,
                                        task: { title: "Add an Activity",
                                                stage: "underway",
                                                description: "",
                                                project_id: project.id
                                  } }
            }.to change(Activity, :count).by(1) 
        end
    end

    describe 'PATCH update' do
        let (:task) { create(:task, project: project) }

        it 'adds activity' do
            expect {
                patch :update, params: { project_id: project.id, id: task.id, 
                    task: { title: "Meep Morp",
                            stage: 'completed',
                            description: '',
                            project_id: project.id
                          } } 
                task.save
                task.reload
            }.to change(Activity, :count).by(1) 
        end
    end

    describe 'DELETE destroy' do
        let (:task) { create(:task, project: project) }

        it 'adds activity' do
            expect { 
                delete :destroy, params: { project_id: project.id, id: task.id }
            }.to change(Activity, :count).by(1)
        end
    end
end
