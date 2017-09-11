class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      @posts = Post.es.search(params[:search]).results
      respond_to do |format|
        format.js { render "posts/results" }
      end
    else
      @posts = Post.order_by(created_at: :desc).paginate(page: params[:page], per_page: 3)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(posts_params)
    if @post.save
      @post.add_attachments(params[:post][:attachments])
      flash[:notice] = 'post_successfully_created'

      respond_to do |format|
        format.js { render 'create' }
      end
    else
      flash[:notice] = 'post_create_error'

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
      @post.save!
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      @posts = Post.order_by(created_at: :desc).paginate(per_page: 3)
      respond_to do |format|
        format.js { render "destroy" }
      end
    end
  end

  def posts_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end
end
