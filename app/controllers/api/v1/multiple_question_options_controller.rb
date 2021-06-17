class Api::V1::MultipleQuestionOptionsController < ApplicationController
  before_action :set_multiple_question_option, only: [:show, :update, :destroy]

  # GET /multiple_question_options
  def index
    @multiple_question_options = MultipleQuestionOption.all

    render json: @multiple_question_options
  end

  # GET /multiple_question_options/1
  def show
    render json: @multiple_question_option
  end

  # POST /multiple_question_options
  def create
    @multiple_question_option = MultipleQuestionOption.new(multiple_question_option_params)

    if @multiple_question_option.save
      render json: @multiple_question_option, status: :created, location: @multiple_question_option
    else
      render json: @multiple_question_option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiple_question_options/1
  def update
    if @multiple_question_option.update(multiple_question_option_params)
      render json: @multiple_question_option
    else
      render json: @multiple_question_option.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiple_question_options/1
  def destroy
    @multiple_question_option.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiple_question_option
      @multiple_question_option = MultipleQuestionOption.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def multiple_question_option_params
      params.require(:multiple_question_option).permit(:label, :correct)
    end
end
