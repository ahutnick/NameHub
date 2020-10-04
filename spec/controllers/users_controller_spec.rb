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
    describe 'POST create' do 
        context 'invalid user is not created' do
            it 'does not add invalid user' do
                expect {
                    post :create, params: { user: { name: 'A',
                                                   email: 'email@nope',
                                                   password: 'pass',
                                                   password_confirmation: 'word'
                                                 } }
                        }. to change(User, :count).by(0)
            end
        end
    end
end
