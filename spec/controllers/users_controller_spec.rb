# == Schema Information
#
# Table name: users
#
# id                         :integer
# name                       :string
# email                      :string
# password_digest            (see below)
# password                   :string
# password_confirmation      :string
#

require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

describe UsersController, type: :controller do 
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
            expect(is_logged_in?).to be true
        end
    end

    describe 'PATCH update' do
        let (:user) { create(:user) }

        it 'allows nil password fields' do
            sign_in(user)
            expect(is_logged_in?).to eq true
            patch :update, params: { id: user.id, user: { name: 'A Test',
                                                          email: 'lkjljl@lkj.ljkl',
                                                          password: '',
                                                          password_confirmation: ''
                                                        } } 
            user.save                                            
            user.reload
            expect(user.name).to eq('A Test')
            expect(user.email).to eq('lkjljl@lkj.ljkl')
        end
    end

    describe 'DELETE destroy' do
        let! (:user) { create(:user) }
        let! (:user2) { create(:user) }


        it "works for the logged in user's profile" do
            sign_in(user)
            expect { 
                delete :destroy, params: { id: user.id }
            }.to change(User, :count).by(-1)
        end

        it "does not allow anyone to destroy someone else's profile" do
            sign_in(user2)
            expect { 
                delete :destroy, params: { id: user.id }
            }.to change(User, :count).by(0)
        end
    end
end
