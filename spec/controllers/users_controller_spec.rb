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
end
