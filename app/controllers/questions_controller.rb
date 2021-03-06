class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: [:show, :edit, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
  end

  def edit
    
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)    
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy    
    if current_user.author?(@question)
      @question.destroy
      redirect_to questions_path, notice: 'The question was deleted.'
    else
      redirect_to questions_path, notice: 'Cant delete.'
    end    
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
