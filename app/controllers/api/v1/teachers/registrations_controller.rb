class Api::V1::Teachers::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def render_create_success
    render json: @resource
  end

  def render_update_success
    render json: @resource
  end

  private

  def sign_up_params
    params.permit(:name, :nickname, :school_id, :email, :password, :cpf, :phone, 
      :status, :password_confirmation, :avatar)
  end

end