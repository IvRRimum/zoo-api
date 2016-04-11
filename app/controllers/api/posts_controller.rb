class Api::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params.merge({user_id: current_user.id}))
    @post.access_validation(current_user)

    respond_to do |format|
      if @post.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
      @post.access_validation(current_user)
    end

    def post_params
      params.require(:post).permit(:title, :body, notes_attributes: [:id, :text, :_destroy])
    end
end
