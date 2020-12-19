class SearchsController < ApplicationController
  def search
    @model = params[:model]
    search = params[:search]
    keyword = params[:keyword]

    if @model == 'user'
      @users = User.search(search, keyword)
    else
      @posts = Post.search(search, keyword)
    end
  end
end
