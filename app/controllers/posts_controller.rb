class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def create
    p params
    @post = Post.new(posts_params)
    @post.image = posts_params["image"]
    # @post = Post.create!(params)
    # @image = @post.image.build

    if @post.save
      redirect_to "/"
    else
      render action 'new'
    end

    # redirect_to posts_url
  end

  def new
    @post = Post.new
  end

  def posts_params
    params.require(:post).permit(:title, :content, :image)
  end

  def image
    @post = Post.find(params[:id])
    content = @post.image.read
    if stale?(etag: content, last_modified: @post.updated_at.utc, public: true)
      send_data content, type: @post.image.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end
end
