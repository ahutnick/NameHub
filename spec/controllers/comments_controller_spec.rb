# == Schema Information
#
# Table name: comments
#
# id                         :integer
# content                    :text
# task_id
#

require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

describe CommentsController, type: :controller do
    let (:task) { create(:task) }

    before(:each) do
        @project = task.project
        @user = @project.user
        sign_in(@user)
    end

    describe 'POST create' do
        it 'renders correctly' do
            post :create, params: { task_id: task.id,
                                    comment: { content: "Testing the comments",
                                               task_id: task.id
                                  } }
            expect(response).to redirect_to('tasks#show')
            expect(flash[:success]).to match(/^New Comment Added!/)
        end

        it 'adds activity' do
            expect {
                post :create, params: { task_id: task.id,
                                    comment: { content: "Testing activity creation",
                                               task_id: task.id
                                  } }
            }.to change(Activity, :count).by(1)
        end
    end

    describe 'DELETE destroy' do
        let (:comment) { create(:comment) }

        it 'adds activity' do
            expect { 
                delete :destroy, params: { task_id: comment.task.id, id: comment.id }
            }.to change(Activity, :count).by(1)
        end
    end
end
