require 'rails_helper'

feature 'User can register', %q{
  User can register.
  Already registered user can't register.
} do 

  scenario 'Non-registered user tries to register' do
    sign_up
    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(current_path).to eq root_path
  end

   
  scenario 'Already registered user tries to register' do
    user = create(:user, email: 'test@test.com', password: '12345678')
    sign_up
    expect(page).to have_content "Email has already been taken"
  end
end