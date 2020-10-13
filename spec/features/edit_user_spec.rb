require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

feature 'edit user' do 
    let (:user) { create(:user) }

    scenario 'has proper routing' do 
        log_in(user)
        visit edit_user_path(user)
        fill_in 'user_name', with: 'A Name'
        fill_in 'user_email', with: 'an-email@ljkdj.lkjdk'
        click_button 'commit'
        expect(page).to have_content('Profile Updated')
        expect(page).to have_content('A NameHub')
    end

    scenario 'need login for edit page, will reroute' do 
        visit edit_user_path(user)
        expect(page).to have_content('New user?')
        log_in(user)
        expect(page).to have_content('Update Profile')
        fill_in 'user_name', with: 'A Name'
        fill_in 'user_email', with: 'a-name@example.com'
        click_button 'commit'
        expect(page).to have_content('Profile Updated')
        expect(page).to have_content('A NameHub')
    end
end
