# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]

  # GET /likes or /likes.json
  def index
    @likes = @user_param ? @user_param.likes.includes(:user, :post).desc.page(params[:page]) : Like.includes(:user, :post).desc.page(params[:page])
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
    if can? :create, @like
      render :new
    else
      head :forbidden
    end
  end

  # GET /likes/1/edit
  def edit
    if can? :edit, @like
      render :edit
    else
      head :forbidden
    end
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new(like_params)
    if can? :create, @like
      @post = Post.find_by_id(@like.post_id) if @like&.post_id
      respond_to do |format|
        if @like.save
          if @post.present?
            format.html { redirect_to @post, notice: "Like was successfully created." }
          else
            format.html { redirect_to @like, notice: "Like was successfully created." }
          end
          format.json { render :show, status: :created, location: @like }
        else
          if @post.present?
            format.html { redirect_to @post, alert: "Like failed to create." }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    else
      head :forbidden
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    if can? :update, @like
      @post = Post.find_by_id(@like.post_id) if @like&.post_id
      is_like = @like.is_like ? "true" : "false"
      respond_to do |format|
        if (@post.present? && like_params[:is_like] == is_like) || @like.update(like_params)
          if @post.present?
            if like_params[:is_like] == is_like
              @like.destroy
              msg = "Like was successfully destroyed."
            else
              msg = "Like was successfully updated."
            end
            format.html { redirect_to @post, notice: msg }
          else
            format.html { redirect_to @like, notice: "Like was successfully updated." }
          end
          format.json { render :show, status: :ok, location: @like }
        else
          if @post.present?
            format.html { redirect_to @post, alert: "Like failed to update." }
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    else
      head :forbidden
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    if can? :destroy, @like
      @like.destroy
      respond_to do |format|
        format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      head :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      if can? :read, Like
        @like = Like.find(params[:id])
      else
        head :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:is_like, :post_id, :user_id).merge(user_id: current_user.id)
    end
end
