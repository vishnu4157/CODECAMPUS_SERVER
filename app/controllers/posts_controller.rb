class PostsController < ApplicationController
    def index
      @posts = Post.all.order(created_at: :desc)
      render json: @posts, include: [:user]
    end
  
    def show
      @post = Post.find(params[:id])
      render json: @post, include: [:user, :comments => { include: [:user]}]
    end
  
    def create
      post = Post.new(post_params)
      if post.save
        render json: post, status: :created
      else
        render json: post.errors, status: :unprocessable_entity
      end
    end
  
    def update
      post = Post.find(params[:id])
      if post.update(post_params)
        render json: post, status: :ok
      else
        render json: post.errors, status: :unprocessable_entity
      end
    end

    def find_cat
      post = Post.where(category: params[:id])
      render json: post, include: [:user]
    end

    def find_user_post
      post = Post.where(user_id: params[:id])
      render json: post, include: [:user]
    end

    def search_posts
      post = Post.where("content LIKE ?", "%" + params[:content] + "%").or(Post.where("category LIKE ?", "%" + params[:content] + "%")).or(Post.where("title LIKE ?", "%" + params[:content] + "%"))
      render json: post, include: [:user]
    end
  
    def destroy
      post = Post.find(params[:id])
      post.destroy
      head :no_content
    end

  
    private
  
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :category)
    end
  end
  