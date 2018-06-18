require 'rails_helper'

feature 'Write an answer', %q{
  Authenticated user can write an 
  answer to the question
} do 
  
  given!(:user) { create(:user) } 
  given!(:question) { create(:question) } 

  scenario 'Authenticated user trie to write an answer' do
    sign_in(user)
    visit questions_path
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    click_on 'Show'
    fill_in 'Body', with: 'test_body_answer'
    click_on 'Create Answer'
    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'test_body_answer'
  end

  scenario 'Non-authenticated user tries to write an answer' do    
    visit questions_path    
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    click_on 'Show'   
    expect(page).to_not have_link 'Create Answer'
  end
end
