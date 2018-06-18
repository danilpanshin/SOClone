require 'rails_helper'

feature 'Only author can delete his question or answer', %q{
  The author of question or answer can delete
  his question or answer but can't delete
  question or answer of another author
} do 

  given!(:user) { create(:user) }
  given!(:some_other_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) } 

  scenario 'User tries to delete his own answer' do
    sign_in(user)
    visit questions_path
    click_on 'Show'
    expect(current_path).to eq question_path(question)
    click_on 'Delete'
    expect(page).to have_content "The answer was deleted."
    expect(page).to_not have_content answer.body
  end

  scenario 'Some other user tries to delete others answer' do
    sign_in(some_other_user)
    visit questions_path
    click_on 'Show'
    expect(current_path).to eq question_path(question)
    expect(page).to_not have_link 'Delete'
  end

  scenario 'Non-registered user tries to delete answer' do
    visit questions_path
    click_on 'Show'
    expect(current_path).to eq question_path(question)
    expect(page).to have_content answer.body
    expect(page).to_not have_link 'Delete'
  end
end