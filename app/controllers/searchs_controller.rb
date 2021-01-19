class SearchsController < ApplicationController
  def search
    @model = params[:model]
    keyword = params[:keyword]

    if @model == 'user'
      @users = User.search(keyword)
    else
      @posts = Post.search(keyword)
    end
  end
end
