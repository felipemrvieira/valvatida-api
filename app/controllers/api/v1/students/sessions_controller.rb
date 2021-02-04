class Api::V1::Students::SessionsController < DeviseTokenAuth::SessionsController
  def render_create_success
    render json: @resource
  end

  private

  def sign_in_params
    params.permit(:email, :password, :password_confirmation)
  end

 
end