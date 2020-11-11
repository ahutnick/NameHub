# == Schema Information
#
# Table name: projects
#
# id                         :integer
# title                      :string
# description                :text
# user_id
#

require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

describe ProjectsController, type: :controller do 
    let! (:project) { create(:project) }

    before(:each) do
        sign_in(project.user)
    end


    describe 'PATCH update' do
        it 'changes one field' do
            sign_in(project.user)
            patch :update, params: { id: project.id, project: { title: "Meep Morp",
                                                                description: '',
                                                                user_id: project.user_id
                                                              } } 
            project.save
            project.reload
            expect(project.title).to eq "Meep Morp"
        end
    end

    describe 'DELETE destroy' do
        it 'increases activity' do
            expect { 
                delete :destroy, params: { id: project.id }
            }.to change(Activity, :count).by(1) 
        end
    end

    describe 'POST create' do
        it 'increases activity' do
            expect { 
                @user = project.user
                post :create, params: { project: { title: 'A',
                                                   user_id: project.user_id
                                                } }
            }.to change(Activity, :count).by(1)
        end
    end
end
