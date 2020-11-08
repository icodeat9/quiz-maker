class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :destroy]
  def index
    @quizzes = current_user.quizzes
  end

  def show
    @quiz = Quiz.find(quizzes_params[:id])
  end

  def new
    @quiz = current_user.quizzes.new
    @quiz.questions.build
  end

  def create
    @quiz = current_user.quizzes.new(quizzes_params)

    if @quiz.save
      flash[:notice] = "Quizz Created"

      redirect_to quizzes_path
    else
      flash[:alert] = @quiz.errors.full_messages.first
      render action: :new
    end
  end

  def destroy
    if @quiz.destroy
      flash[:notice] = "Quizz Deleted"

      redirect_to quizzes_path
    else
      flash[:danger] << @quiz.errors
    end
  end

  private

  def quizzes_params
    params.require(:quiz).permit(
      :id,
      :name,
      questions_attributes: [
        :title,
        answers_attributes: [
          :text
        ]
      ]
    )
  end

  def set_quiz
    @quiz ||= Quiz.find(quizzes_params[:id])
  end
end
