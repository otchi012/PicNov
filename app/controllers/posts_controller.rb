class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user
    if @post.save
      flash[:notice] ='You have created post successfully'
      redirect_to post_path(@post)
    else
      @post = Post.new
      render :new
    end
  end

  def index
    @posts = Post.all
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user = current_user
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] ='You have updated post successfully'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] ='You have destroyed post successfully'
      redirect_to posts_path
    else
      render :index
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
