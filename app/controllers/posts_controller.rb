class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    @post.post_images.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] ='投稿を登録しました。'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    # binding.pry
    @posts = Post.all
    @posts = Post.tagged_with("#{params[:tag_name]}") if params[:tag_name]
    # ランキング機能
    posts = @posts.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
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
      flash[:notice] ='投稿を更新しました。'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] ='投稿を削除しました。'
      redirect_to posts_path
    else
      render :index
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :tag_list, post_images_images: [])
  end
end
