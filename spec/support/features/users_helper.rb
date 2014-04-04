module Features
  def sign_in(email, password)
    visit signin_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign In'
  end
end
