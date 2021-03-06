class Api::V1::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question, include: [:teacher, :subject, :multiple_question_options,
      :open_question_answers]
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created, location: api_v1_question_path(@question)
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:label, :command, :subject_id, :teacher_id, 
        :kind, multiple_question_options_attributes: [:id, :label, :correct, :_destroy], 
        open_question_answers_attributes: [:id, :answer, :_destroy])
    end 
end
