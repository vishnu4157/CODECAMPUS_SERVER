class CommentsController < ApplicationController
    # before_action :authenticate_request, only: [:create, :destroy, :update]
    def index
      @comments = Comment.all
      render json: @comments
    end
  
    def create
      comment = Comment.new(comment_params)
      if comment.save
        render json: comment, status: :created
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    end

    def show
      @comment = Comment.find(params[:id])
      render json: @comment, include: [:post]
    end

    def find
      comment = Comment.where(post_id: params[:id])
      render json: comment, include: [:user, :post]
    end
  
    def update
      comment = Comment.find(params[:id])
      if comment.update(comment_params)
        render json: comment, status: :ok
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      comment = Comment.find(params[:id])
      comment.destroy
      head :no_content
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id, :reply)
    end
  end
  