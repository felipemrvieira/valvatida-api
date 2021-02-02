class CourseGroupsController < ApplicationController
  before_action :set_course_group, only: [:show, :update, :destroy]

  # GET /course_groups
  def index
    @course_groups = CourseGroup.all

    render json: @course_groups
  end

  # GET /course_groups/1
  def show
    render json: @course_group
  end

  # POST /course_groups
  def create
    @course_group = CourseGroup.new(course_group_params)

    if @course_group.save
      render json: @course_group, status: :created, location: @course_group
    else
      render json: @course_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /course_groups/1
  def update
    if @course_group.update(course_group_params)
      render json: @course_group
    else
      render json: @course_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /course_groups/1
  def destroy
    @course_group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_group
      @course_group = CourseGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_group_params
      params.require(:course_group).permit(:title)
    end
end
