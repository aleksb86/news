class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  PER_PAGE = 3

  def index
    if params[:search]
      @posts = Post.es.search(params[:search]).results
      respond_to do |format|
        format.js { render "results" }
      end
    else
      @posts = Post.order_by(created_at: :desc).paginate(page: params[:page], per_page: PER_PAGE)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(posts_params)
    if @post.save || @post.add_attachments(params[:post][:attachments])
      flash.now[:success] = I18n.t(:post_created_succeeded, scope: :alert)
      respond_to do |format|
        format.js { render 'create' }
      end
    else
      flash.now[:danger] = @post.errors.full_messages
      respond_to do |format|
        format.js { render 'new' }
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(posts_params)
      @post.add_attachments(params[:post][:attachments])
      flash.now[:success] = I18n.t(:post_updated_succeeded, scope: :alert)
      respond_to do |format|
        format.js { render 'update'}
      end
    else
      flash.now[:danger] = @post.errors.full_messages
      respond_to do |format|
        format.js { render 'edit' }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  private

  def posts_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end

end
