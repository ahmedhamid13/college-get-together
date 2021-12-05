# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_follow, only: %i[ show edit update destroy ]

  # GET /follows or /follows.json
  def index
    @follows = @user_param ? @user_param.follows.includes(:user, :followed).desc.page(params[:page]) : Follow.includes(:user, :followed).desc.page(params[:page])
  end

  # GET /follows/1 or /follows/1.json
  def show
  end

  # GET /follows/new
  def new
    @follow = Follow.new
    if can? :create, @follow
      render :new
    else
      head :forbidden
    end
  end

  # GET /follows/1/edit
  def edit
    if can? :edit, @follow
      render :edit
    else
      head :forbidden
    end
  end

  # POST /follows or /follows.json
  def create
    @follow = Follow.new(follow_params)
    if can? :create, @follow
      respond_to do |format|
        if @follow.save
          format.html { redirect_to @follow, notice: "Follow was successfully created." }
          format.json { render :show, status: :created, location: @follow }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @follow.errors, status: :unprocessable_entity }
        end
      end
    else
      head :forbidden
    end
  end

  # PATCH/PUT /follows/1 or /follows/1.json
  def update
    if can? :update, @follow
      respond_to do |format|
        if @follow.update(follow_params)
          format.html { redirect_to @follow, notice: "Follow was successfully updated." }
          format.json { render :show, status: :ok, location: @follow }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @follow.errors, status: :unprocessable_entity }
        end
      end
    else
      head :forbidden
    end
  end

  # DELETE /follows/1 or /follows/1.json
  def destroy
    if can? :destroy, @follow
      @follow.destroy
      respond_to do |format|
        format.html { redirect_to follows_url, notice: "Follow was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      head :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      if can? :read, Follow
        @follow = Follow.find(params[:id])
      else
        head :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:followed_id).merge(user_id: current_user.id)
    end
end
