class PostsController < ApplicationController
  def index
    @posts = if params[:keywords]
      Post.where('title like ?', "%#{params[:keywords]}%")
    else
      []
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
