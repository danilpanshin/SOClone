require 'rails_helper'

feature 'Only author can delete his question', %q{
  The author of question can delete
  his question but can't delete
  question of another author
} do 

  given(:user) { create(:user) }
  given!(:some_other_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  
  scenario 'User can delete his own question' do
    sign_in(user)    
    visit questions_path
    expect(page).to have_content question.title
    click_on 'Delete'
    expect(current_path).to eq questions_path
    expect(page).to have_content "The question was deleted."
    expect(page).to_not have_content question.title
  end

  scenario 'User tries to delete question of another user' do
    sign_in(some_other_user)
    visit questions_path
    expect(page).to have_content question.title
    expect(page).to_not have_link 'Delete'
  end

  scenario 'Guest tries to delete question' do
    visit questions_path
    expect(page).to have_content question.title
    expect(page).to_not have_link 'Delete'
  end
end