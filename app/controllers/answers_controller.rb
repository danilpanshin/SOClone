class AnswersController < ApplicationController

  before_action :set_question, only: %i[new create]
  before_action :set_answer, only: :show

  
  def new
    @answer = @question.answers.new
  end

  def show; end

  def create
    @answer = @question.answers.create(answer_params)
    
    if @answer.save
      redirect_to question_answer_path(id: @answer) #question_answer_path(id: @question)
    else
      render :new
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
