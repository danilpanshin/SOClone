require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  # describe 'GET #show' do
  #   before { get :show, params: { id: answer } }

  #   it 'assigns the request answer to @answer' do
  #     expect(assigns(:answer)).to eq answer
  #   end

  #   it 'render show view' do
  #     expect(response).to render_template :show
  #   end
  # end

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'assigns a new answer to @answers' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end


  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(Answer, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to  action: :show, id: assigns(:answer).id #question_answer_path(assigns(:answer))  
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
end
