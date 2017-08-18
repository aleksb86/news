class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(posts_params)
    # @post.image = posts_params[:image]
    @post.attachments = params[:post][:attachments].map do |photo|
    #   p 'attachments PHOTO'
    #   p photo
      attachment = Attachment.new
      attachment.photo = photo
      attachment.post_id = @post.id
      attachment.save
      attachment
    end
    # p 'POST ATTACHMENTS:'
    # p @post.attachments

    if @post.save
      redirect_to "/"
    else
      render action 'new'
    end
  end

  def new
    @post = Post.new
  end

  def posts_params
    params.require(:post).permit(:title, :content, :image)
  end

  # def image
  #   @post = Post.find(params[:id])
  #   content = @post.image.read
  #   if stale?(etag: content, last_modified: @post.updated_at.utc, public: true)
  #     send_data content, type: @post.image.file.content_type, disposition: "inline"
  #     expires_in 0, public: true
  #   end
  # end
  # def attachment
  #   p "attachment PARAMS:"
  #   p params
    # @post = Post.find(params[:id])
    # # content = @post.attachments.read
    # @attachment = Attachment.find()
    # if stale?(etag: content, last_modified: @post.updated_at.utc, public: true)
    #   send_data content, type: @post.attachments.file.content_type, disposition: "inline"
    #   expires_in 0, public: true
    # end
  # end
end
