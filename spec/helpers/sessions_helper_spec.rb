require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
  c.include LoginHelpers
end

# Add cookies test (show_me_the_cookies?)

RSpec.describe SessionsHelper, type: :helper do
  describe "current_user" do 
    let (:user) { create(:user) }

    it 'returns right when session is nil' do 
      helper.remember(user)
      expect(user).to eq helper.current_user
      expect(is_logged_in?).to eq true 
    end

    it 'returns nil when remember_digest is wrong' do
      helper.remember(user)
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user.nil?).to eq true
    end
  end
end
