require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:some_other_user) { create(:user) }
  
  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js } }.to change(question.answers, :count).by(1)
      end
      
      it 'render create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create  
      end
      
      it 'answer associated with the author' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(assigns(:answer).user_id).to eq @user.id
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do   
    before { sign_in(answer.user) }
           
    context 'User deletes his own answer' do      
      it 'deletes answer' do
        expect { delete :destroy, params: { question_id: question, id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question view' do
        delete :destroy, params: { question_id: question, id: answer }
        expect(response).to redirect_to question
      end
    end

    context 'User trying deletes another user`s answer' do
      before { sign_in(some_other_user) }

      it 'does not deletes answer' do
        expect { delete :destroy, params: { question_id: question, id: answer } }.to_not change(Answer, :count)
      end

      it 'redirect to questions view' do
        delete :destroy, params: { question_id: question, id: answer }
        expect(response).to redirect_to questions_path
      end
    end
  end
end
