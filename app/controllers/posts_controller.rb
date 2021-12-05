# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if can? :read, Post
      @posts = @user_param ? @user_param.posts.includes(:user, :comments, :likes).desc.page(params[:page]) : Post.includes(:user, :comments, :likes).desc.page(params[:page])
    else
      head :forbidden
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    if @post
      @comments = @post.comments.includes(:user, :post).desc.page(params[:page])
      @like = current_user.likes.find_by(post_id: @post.id) if current_user
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
    if can? :create, @post
      render :new
    else
      head :forbidden
    end
  end

  # GET /posts/1/edit
  def edit
    if can? :edit, @post
      render :edit
    else
      head :forbidden
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    if can? :create, @post
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      head :forbidden
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if can? :update, @post
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      head :forbidden
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if can? :destroy, @post
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      head :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      if can? :read, Post
        @post = Post.find(params[:id])
      else
        head :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
    end
end
