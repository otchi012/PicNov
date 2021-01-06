class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    @post.post_images.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    # binding.pry
    result = false
    @post.post_images.each do |image|
      result = Vision.check_unsafe_image_data(image)
      # 一つでも不正コンテンツがあれば抜ける
      if result == true
        break
      end
    end
    # saveされて且つ不正コンテンツがない場合は投稿できる
    if @post.save && result == false
      flash[:notice] = '投稿を登録しました。'
      redirect_to post_path(@post)
    # saveされたが不正コンテンツが一つでもある場合は削除してrenderする
    elsif @post.save && result == true
      @post.destroy
      flash[:notice] = '画像が不適切です'
      render :new
    # バリデーションで引っかかった場合のrender
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @tags = Post.tag_counts_on(:tags).most_used(20)
    @posts = Post.tagged_with("#{params[:tag_name]}") if params[:tag_name]
    # ランキング機能
    posts = @posts.includes(:favorited_users).
      sort { |a, b| b.favorited_users.size <=> a.favorited_users.size }
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    render :edit unless @post.update(post_params)
    result = false
    @post.post_images.each do |image|
      result = Vision.check_unsafe_image_data(image)
      # 一つでも不正コンテンツがあれば抜ける
      if result == true
        break
      end
    end
    if result == true
      @post.destroy
      flash[:notice] = '画像が不適切です'
      render :edit
    end
    flash[:notice] = '投稿を更新しました。'
    redirect_to post_path(@post)
    # if @post.update(post_params)
    #   flash[:notice] = '投稿を更新しました。'
    #   redirect_to post_path(@post)
    # else
    #   render :edit
    # end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = '投稿を削除しました。'
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
