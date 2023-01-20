class SessionsController < ApplicationController

  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      payload = { user_id: user.id }
      token = JWT.encode(payload, SECRET_KEY)
      render json: { jwt: token, username: user.username }
    else
      render json: { error: "Invalid Password or Username"}, status: 401
    end
  end


  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
