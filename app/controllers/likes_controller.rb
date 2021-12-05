# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]

  # GET /likes or /likes.json
  def index
    @likes = @user_param ? @user_param.likes.includes(:user, :post).order(:created_at).page(params[:page]) : Like.includes(:user, :post).order(:created_at).page(params[:page])
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
      respond_to do |format|
        if @like.save
          format.html { redirect_to @like, notice: "Like was successfully created." }
          format.json { render :show, status: :created, location: @like }
        else
          format.html { render :new, status: :unprocessable_entity }
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
      respond_to do |format|
        if @like.update(like_params)
          format.html { redirect_to @like, notice: "Like was successfully updated." }
          format.json { render :show, status: :ok, location: @like }
        else
          format.html { render :edit, status: :unprocessable_entity }
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
      params.require(:like).permit(:is_like, :user_id).merge(user_id: current_user.id)
    end
end
