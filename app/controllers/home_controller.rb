# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[ act_as_normal ]
  skip_before_action :authenticate_user!, only: %i[ set_theme act_as_normal ]

  def index
  end

  def about
  end

  def contact
  end

  def set_theme
    if params[:theme_mode] == "on"
      cookies.permanent[:dark_mode] = "dark"
    else
      cookies.permanent[:dark_mode] = "light"
    end
    redirect_to request.referer
  end

  def act_as_normal
    if current_user.role_is?("admin")
      if params[:as_normal] == "on"
        cookies.permanent[:as_normal] = "normal"
      else
        cookies.permanent[:as_normal] = "admin"
      end
      redirect_to root_path
    end
  end
end
