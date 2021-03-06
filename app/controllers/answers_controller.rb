class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %i[create]
  before_action :set_answer, only: %i[destroy] 

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy    
    if current_user.author?(@answer)
      @answer.destroy
      redirect_to question_path(@answer.question) , notice: 'The answer was deleted.'
    else
      redirect_to questions_path, notice: "Can't delete."
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
