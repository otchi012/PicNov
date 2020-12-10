class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '更新しました'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def following
    @user = User.find(params[:id])
    @title = "Following"
    @users = @user.following
    render 'show_following'
  end

  def followers
    @user  = User.find(params[:id])
    @title = "Followers"
    @users = @user.followers
    render 'show_followers'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end

end
