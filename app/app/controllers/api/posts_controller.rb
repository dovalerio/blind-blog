module Api
  class PostsController < BaseController
    before_action :set_post, only: [:show, :update, :destroy]

    def index
      posts = Post.order(created_at: :desc)
      render json: posts
    end

    def show
      render json: @post
    end

    def create
      post = Post.new(post_params)
      if post.save
        render json: post, status: :created
      else
        render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      head :no_content
    end

    private

    def set_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Post não encontrado" }, status: :not_found
    end

    def post_params
      params.require(:post).permit(:title, :content, :published)
    end
  end
end
