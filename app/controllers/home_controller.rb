class HomeController < ApplicationController
  def index
    @users = User.all
    @posts = paginate(Post, params[:page], 5)
    # @posts = Post.skip(0).limit(5).entries
  end
end
