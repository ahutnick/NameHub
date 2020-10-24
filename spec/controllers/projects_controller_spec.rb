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

describe ProjectsController, type: :controller do 
    let! (:project) { create(:project) }

    describe 'PATCH update' do
        it 'changes one field' do
            patch :update, params: { id: project.id, project: { title: "Meep Morp",
                                                                description: '',
                                                                user_id: project.user_id
                                                              } } 
            project.save
            project.reload
            expect(project.title).to eq "Meep Morp"
        end
    end
end
