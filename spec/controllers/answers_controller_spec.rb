require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  
  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
      end
      
      it 'redirects to question show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to question_path(assigns(:question))  
      end
      
      it 'answer associated with the author' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(assigns(:answer).user_id).to eq @user.id
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do   
    before { sign_in(answer.user) }
           
    context 'User deletes his own answer' do      
      it 'deletes answer' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question
      end
    end

    context 'User trying deletes another user`s answer' do
      let!(:some_other_user) { create(:user) }
      let!(:some_other_answer) { create(:answer, question: question, user: some_other_user) }

      it 'does not deletes answer' do
        expect { delete :destroy, params: { id: some_other_answer} }.to_not change(Answer, :count)
      end

      it 'redirect to question view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
