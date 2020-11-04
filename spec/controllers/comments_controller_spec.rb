# == Schema Information
#
# Table name: comments
#
# id                         :integer
# content                    :text
# task_id
#

require 'rails_helper'

describe CommentsController, type: :controller do
    let (:task) { create(:task) }

    describe 'POST create' do
        it 'renders correctly' do
            post :create, params: { task_id: task.id,
                                    comment: { content: "Testing the comments",
                                               task_id: task.id
                                  } }
            #expect(response).to redirect_to('tasks/show')
            expect(flash[:success]).to match(/^New Comment Added!/)
        end
    end
end
