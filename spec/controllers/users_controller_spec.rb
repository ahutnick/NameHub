# == Schema Information
#
# Table name: users
#
# id                         :integer
# name                       :string
# email                      :string
# password                   :string
# password_confirmation      :string
#

require 'rails_helper'

describe UsersController, type: :controller do 
    describe 'GET index' do 
        it 'does not get index' do 
            get :index
            expect(response).not_to be_successful
        end
    end

    describe 'POST create' do 
        it 'does not add invalid user' do
            expect {
                post :create, params: { user: { name: 'A',
                                                email: 'email@nope',
                                                password: 'pass',
                                                password_confirmation: 'word'
                                                } }
            }. to change(User, :count).by(0)
        end

        it "does add valid user" do
            expect {
                post :create, params: { user: { name: 'A Test',
                                                email: 'email@example.com',
                                                password: 'foobar',
                                                password_confirmation: 'foobar'
                                                } }
            }. to change(User, :count).by(1)
        end
    end
end
