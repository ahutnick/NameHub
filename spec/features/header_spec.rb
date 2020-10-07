require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

feature 'Header' do 
    
    scenario "Not logged in" do
        visit home_path
        expect(page).to have_content("Log In")
    end

    scenario "Logged in" do 
        user = create(:user)
        log_in(user)
        expect(page).to have_content("Profile")
        click_on("Profile")
        expect(page).to have_content("Dashboard")
        expect(page).to have_content("Log Out")
    end
end
