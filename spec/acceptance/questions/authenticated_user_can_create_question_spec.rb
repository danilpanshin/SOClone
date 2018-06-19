require 'rails_helper'

feature 'Authenticated user can create questions', %q{
  Only authenticated user can create
  questions
} do 

  given(:user) { create(:user) }

  scenario 'Authenticated user tries to create question and answer' do
    sign_in(user)
    visit root_path
    click_on 'Ask question'
    expect(current_path).to eq new_question_path
    fill_in 'Title', with: 'TestQuestionTitle'
    fill_in 'Body', with: 'TestQuestionBody'
    click_on 'Create'
    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'TestQuestionTitle'
    expect(page).to have_content 'TestQuestionBody'   
  end

  scenario 'Non-authenticated user tries to create question' do
    visit root_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user creates question without attributes' do
    sign_in(user)
    visit root_path
    click_on 'Ask question'
    click_on 'Create'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end
end