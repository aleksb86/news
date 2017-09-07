class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    if params[:search]
      # Will return array of Post instances (if found any)
      @posts = Post.es.search(params[:search]).results
      respond_to do |format|
        format.html
        format.js { render "posts/results" }
      end
    end
    # @users = User.all
    # pagination:
    if params[:page].nil?
      pages = 0
    else
      pages = params[:page].to_i - 1
    end
    @posts = Post.skip(pages).limit(5).entries
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

    unless current_user.nil?
      @post.user_id = current_user.id
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
          format.js
        end
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
          p "ATTACHMENT save: #{attachment.errors.messages}"
          attachment
        end
      end
      p "POST ATTACHMENTS: #{@post.attachments}"
      @post.save

      @posts = Post.all
      respond_to do |format|
        format.html
        format.js { render "index" }
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

  def posts_params
    params.require(:post).permit(:title, :content)
  end
end
