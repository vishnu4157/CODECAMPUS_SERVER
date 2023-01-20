class UsersController < ApplicationController
    # before_action :authenticate_request, only: [:update, :destroy]
    before_action :authenticate_request, only: [:current_user_id]

    SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

    def index
      @users = User.all
      render json: @users, only: [:name, :username, :id]
    end
  
    def create
      user = User.new(user_params)
      if user.save
        payload = { user_id: user.id }
        token = JWT.encode(payload, SECRET_KEY)
        render json: { jwt: token, user_id: user.id }, status: :created
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    end
  
    def update
      user = User.find(params[:id])
      if user.update(user_params)
        render json: user, status: :ok
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      user = User.find(params[:id])
      user.destroy
      head :no_content
    end

    def current_user_id
      render json: @current_user
    end

    def get_username
      post = User.find(params[:id])
      render json: post.username
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :username, :password)
    end
    
    def authenticate_request
      auth_header = request.headers['Authorization']
      if auth_header
        token = auth_header.split(' ')[1]
        begin
          @decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
          render json: @decoded
        rescue JWT::DecodeError
          render json: {error: "unauth access"}
        end
      end
    end

end
  