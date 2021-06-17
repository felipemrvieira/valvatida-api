class Api::V1::OpenQuestionAnswersController < ApplicationController
  before_action :set_open_question_answer, only: [:show, :update, :destroy]

  # GET /open_question_answers
  def index
    @open_question_answers = OpenQuestionAnswer.all

    render json: @open_question_answers
  end

  # GET /open_question_answers/1
  def show
    render json: @open_question_answer
  end

  # POST /open_question_answers
  def create
    @open_question_answer = OpenQuestionAnswer.new(open_question_answer_params)

    if @open_question_answer.save
      render json: @open_question_answer, status: :created, location: @open_question_answer
    else
      render json: @open_question_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /open_question_answers/1
  def update
    if @open_question_answer.update(open_question_answer_params)
      render json: @open_question_answer
    else
      render json: @open_question_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /open_question_answers/1
  def destroy
    @open_question_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_question_answer
      @open_question_answer = OpenQuestionAnswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def open_question_answer_params
      params.fetch(:open_question_answer, {})
    end
end
