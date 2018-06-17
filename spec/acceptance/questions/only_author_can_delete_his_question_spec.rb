require 'rails_helper'

feature 'Only author can delete his question or answer', %q{
  The author of question or answer can delete
  his question or answer but can't delete
  question or answer of another author
} do 

  given(:user) { create(:user) }
  given!(:some_other_user) { create(:user) }
  given!(:question)     { create(:question, user: user) }
  
  scenario 'User can delete his own question' do
    sign_in(user)
    
    visit questions_path
    
    click_on 'Delete'
    expect(current_path).to eq questions_path
    expect(page).to have_content "The question was deleted."
  end

  scenario 'User tries to delete question of another user' do
    sign_in(some_other_user)
    visit questions_path
    expect(page).to_not have_link 'Delete'
  end
  


end