require 'rails_helper'
require './spec/support/login_helpers.rb'
require 'webdrivers/chromedriver'

RSpec.configure do |c|
    c.include LoginHelpers
end

feature "log in and out" do 
    let (:user) { create(:user) }
    let (:user2) { create(:user) }

    scenario "with multiple windows", js: true do 
        log_in(user)
        new_window = open_new_window
        within_window new_window do 
            visit home_path 
        end
        click_link 'Log Out'
        within_window new_window do 
            click_link 'Log Out'
            expect(page).to have_content("Log In")
        end
    end

    scenario "login only shows current user" do
        log_in(user)
        visit user2.id.to_s
        expect(page).to have_content("Welcome!")
    end
        
end
