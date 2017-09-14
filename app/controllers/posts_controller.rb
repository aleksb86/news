class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      @posts = Post.es.search(params[:search]).results
      respond_to do |format|
        format.js { render "results" }
      end
    else
      @posts = Post.order_by(created_at: :desc)
        .paginate(page: params[:page], per_page: per_page)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(posts_params)
    if @post.save!
      @post.add_attachments(params[:post][:attachments])
      # @posts = Post.order_by(created_at: :desc)
      #   .paginate(page: params[:page], per_page: per_page)

      flash.now[:success] = 'post_successfully_created'

      respond_to do |format|
        format.js { render 'create', locals: {post: @post} }
      end
    else
      flash.now[:danger] = 'post_create_error'

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
      # @post.save!
      respond_to do |format|
        format.js { render 'update', locals: {post: @post} }
      end
      flash.now[:success] = 'post_update_succeeded'
    else
      respond_to do |format|
        format.js { render 'edit' }
      end
      flash.now[:danger] = 'post_update_failed'
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:success] = 'post_delete_success'
      @posts = Post.order_by(created_at: :desc)
        .paginate(page: params[:page], per_page: per_page)
    else
      flash[:danger] = 'post_delete_error'
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end

  def per_page
    3
  end
end
