class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @q = Post.order(created_at: :desc).ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(2)
    @new_posts = Post.find_newest_artical
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to "/posts/#{@post.id}"
    # redirect_to @postでも行ける
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to "/posts/#{@post.id}"
  end

  def destroy
    @post.destroy
    redirect_to "/"
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :category)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
