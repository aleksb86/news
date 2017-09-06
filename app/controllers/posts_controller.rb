class PostsController < ApplicationController
  before_filter :authenticate_user!
  def index
    if params[:search]
      # Will return array of Post instances (if found any)
      @posts = Post.es.search(params[:search]).results
      respond_to do |format|
        format.html
        format.js { render "posts/results" }
      end
    else
      @posts = Post.all
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(posts_params)
    unless params[:post][:attachments].nil?
      @post.attachments = params[:post][:attachments].map do |photo|
        attachment = Attachment.new
        attachment.photo = photo
        attachment.post_id = @post.id
        attachment.save
        attachment
      end
    end

    respond_to do |format|
      if request.xhr? || remotipart_submitted?
        if @post.save
          format.html
          format.js { redirect_to "/posts.js" }#, :status => :created,
            # :location => @post, :layout => !request.xhr? }
          # format.json { render json: @post, status: :created }
        else
          format.html { render action: "new" }
        end
      else
        p "remotipart not used!"
      end
    end
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @post = Post.find(params[:id])
    @post.attachments = Attachment.where(post_id: @post.id)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(posts_params)

      unless params[:post][:attachments].nil?
        @post.attachments += params[:post][:attachments].map do |photo|
          attachment = Attachment.new
          attachment.photo = photo
          attachment.post_id = @post.id
          attachment.save
          attachment
        end
      end

      @posts = Post.all
      respond_to do |format|
        format.html
        format.js { render "posts/index" }
      end
    else
      format.html
      format.js
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      @posts = Post.all
      respond_to do |format|
        format.html
        format.json
        format.js { render "posts/index" }
      end
    end
  end

  # def search
  #   @posts = Post.es.search(params[:search])
  #   respond_to do |format|
  #     format.html
  #     format.json
  #     format.js { render "posts/index" }
  #   end
  # end

  def posts_params
    params.require(:post).permit(:title, :content)
  end
end
