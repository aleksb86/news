class PostsController < ApplicationController

  def index
    @posts = Post.all
    respond_to do |format|
      format.js
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
          format.html #{ redirect_to @post, :layout => !request.xhr? }
          # format.js { render :js => @post }#, :status => :created,
            # :location => @post, :layout => !request.xhr? }
          format.js #{ redirect_to "home/index" }#, :status => :created,
            # :location => @post, :layout => !request.xhr? }
          # format.json { render json: @post, status: :created }
        else
          format.html { render action: "new" }
          # format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      else
        p "remotipart not used!"
      end
    end

    # if @post.save
    #   redirect_to "/"
    # else
    #   render action 'new'
    # end
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

    # p @post.attachments
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(posts_params)
        format.html
        format.js
      else
        format.html {render action: "edit"}
        format.js
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy

    respond_to do |format|
      format.html { redirect_to "/" }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  def posts_params
    params.require(:post).permit(:title, :content)
  end
end
