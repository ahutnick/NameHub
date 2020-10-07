require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

feature 'Header' do 
    let(:user) { create(:user) }
    
    scenario "Not logged in" do
        visit home_path
        expect(page).to have_content("Log In")
    end

    scenario "Logged in" do 
        log_in(user)
        expect(page).to have_content("Profile")
        click_on("Profile")
        expect(page).to have_content("Dashboard")
        expect(page).to have_content("Log Out")
    end

    scenario "Sign up starts log in header" do 
        sign_up
        expect(page).to have_content("Log Out")
    end

    scenario "Log out" do 
        log_in(user)
        click_on("Log Out")
        expect(page).to have_content("Log In")
    end
end
