module AcceptanceHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def view_questions
    visit questions_path
    
    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end

  def view_answers
    visit questions_path
        
    click_on 'Show'
    
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    
    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  def sign_up
    visit new_user_registration_path
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
  end
end