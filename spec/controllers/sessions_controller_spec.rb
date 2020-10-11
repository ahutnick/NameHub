# == Schema Information
#
# Table name: sessions
#
# email                      :string
# password                   :string
#

require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

describe SessionsController, type: :controller do 
    let (:user) { create(:user) }
    describe 'POST create and DELETE destroy' do 
        it "logs in and out" do 
            post :create, params: { session: { email: user.email,
                                                password: user.password } }
            expect(is_logged_in?).to be true
            delete :destroy 
            expect(is_logged_in?).to be false
            delete :destroy 
        end
    end
end
