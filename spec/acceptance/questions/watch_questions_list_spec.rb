require 'rails_helper'

feature 'Watch list of question', %q{
  User can view the list of questions
} do
  
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3) }

  scenario 'Registered user try to view' do
    sign_in(user)    
    view_questions
  end

  scenario 'Unregistered user try to view' do    
    view_questions
  end
end

