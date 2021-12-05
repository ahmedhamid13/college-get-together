# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    if can? :read, Comment
      @comments = @user_param ? @user_param.comments.includes(:user, :post).desc.page(params[:page]) : Comment.includes(:user, :post).desc.page(params[:page])
    else
      head :forbidden
    end
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    if can? :create, @comment
      render :new
    else
      head :forbidden
    end
  end

  # GET /comments/1/edit
  def edit
    if can? :edit, @comment
      render :edit
    else
      head :forbidden
    end
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    if can? :create, @comment
      @post = Post.find_by_id(@comment.post_id) if @comment&.post_id
      respond_to do |format|
        if @comment.save
          if @post.present?
            format.html { redirect_to @post, notice: "Comment was successfully created." }
          else
            format.html { redirect_to @comment, notice: "Comment was successfully created." }
          end
          format.json { render :show, status: :created, location: @comment }
        else
          if @post.present?
            format.html { redirect_to @post, alert: "Comment failed to create." }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      head :forbidden
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    if can? :update, @comment
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @comment, notice: "Comment was successfully updated." }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      head :forbidden
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    if can? :destroy, @comment
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      head :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      if can? :read, Comment
        @comment = Comment.find(params[:id])
      else
        head :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :post_id).merge(user_id: current_user.id)
    end
end
