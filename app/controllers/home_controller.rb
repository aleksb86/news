class HomeController < ApplicationController
  def index
    @users = User.all
    @posts = Post.all
    # @attachments = Post.includes(:attachments).map(&:attachments).flatten
    # p "ATTACHMENTS:"
    # p @attachments
  end
end
