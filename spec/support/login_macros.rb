module LoginMacros # in rails_helper.rb, include: config.include LoginMacros
  def sign_in_with_form(user)
    visit root_path # with capybara
    click_link 'Login'
    fill_in 'user_email', with: user.email # fill_in accepts name, id or label text
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end
end
