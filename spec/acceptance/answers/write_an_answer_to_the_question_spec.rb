require 'rails_helper'

feature 'Write an answer', %q{
  Authenticated user can write an 
  answer to the question
} do 
  
  given(:user) { create(:user) }
  

  scenario 'Authenticated user trie to write an answer' do
    sign_in(user)
    question = create(:question)
    
    visit "/questions"
    click_on 'Show'
    fill_in 'Body', with: 'test_body_answer'
    click_on 'Create Answer'

    expect(page).to have_content 'test_body_answer'
  end

  scenario 'Non-authenticated user tries to write an answer' do 
    
    visit questions_path    
    click_on 'Ask question'
    
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
