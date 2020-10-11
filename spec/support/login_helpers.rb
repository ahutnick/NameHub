module LoginHelpers
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  def log_in(user)
      visit login_path
      fill_in "session_email", with: user.email
      fill_in "session_password", with: user.password
      click_button "commit"
  end

  def log_in_remember(user)
    visit login_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    page.check "session_remember_me"
    click_button "commit"
  end

  def sign_up
    user = build(:user)
    visit signup_path
    fill_in "user_name", with: user.name
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    click_button "commit"
  end
end
