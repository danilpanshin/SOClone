require 'rails_helper'

feature 'View a question and its answers', %q{
  As a user I want to view some question
  and its answers
} do  
   
  given(:user) { create(:user) }
  given(:question) { create(:question ) }
  given!(:answers) { create_list(:answer, 3, question: question) }

  scenario 'Registered user tries to view question and its answers' do
    sign_in(user)
    view_answers
  end

  scenario 'Unregistered user tries to view question and its answers' do
    view_answers
  end
end