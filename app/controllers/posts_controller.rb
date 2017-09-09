class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      @posts = Post.es.search(params[:search]).results
      respond_to do |format|
        format.js { render "posts/results" }
      end
    else
      @posts = Post.paginate(page: params[:page], per_page: 3)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(posts_params)
    unless params[:post][:attachments].nil?
      @post.attachments = params[:post][:attachments].map do |photo|
        attachment = Attachment.new(photo: photo, post_id: @post.id).save
        attachment
        # attachment = Attachment.new
        # attachment.photo = photo # better by hash in new method call
        # attachment.post_id = @post.id
        # attachment.save
        # attachment
      end
    end

    unless current_user.nil?
      @post.user_id = current_user.id
    end

    respond_to do |format|
      if request.xhr? || remotipart_submitted?
        if @post.save
          format.html
          format.js # { render layout: false }#, :status => :created,
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
          attachment.photo = photo #  смотри  new action
          attachment.post_id = @post.id
          attachment.save
          attachment
        end
      end

      # @posts = Post.all
      @posts = Post.paginate(page: params[:page], per_page: 3)
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
      # @posts = Post.all
      @posts = Post.paginate(page: params[:page], per_page: 3)
      respond_to do |format|
        format.html
        format.json
        format.js { render "index" }
      end
    end
  end

  def posts_params
    params.require(:post).permit(:title, :content)
  end
end
