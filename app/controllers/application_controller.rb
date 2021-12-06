# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Auth::UserRoles

  protect_from_forgery with: :exception
  around_action :switch_locale
  before_action :set_theme_color, :set_user_type, :set_user_param
  before_action :authenticate_user!, if: :cud_request?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :premium, :image, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :user_role, :premium, :image, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :user_role, :premium, :image, :password, :password_confirmation])
    end

    def set_user_param
      @user_param = User.find_by_id(params[:user_filter]) if params[:user_filter]
    end

  private
    def set_theme_color
      cookies.permanent[:dark_mode] = "light" unless cookies[:dark_mode]
      @dark_mode = cookies[:dark_mode] == "light" ? false : true
    end

    def set_user_type
      cookies.permanent[:as_normal] = "admin" unless cookies[:as_normal]
      @act_as_normal = cookies[:as_normal] == "admin" ? false : true
    end

    def switch_locale(&action)
      I18n.default_locale == "ar" ? @dir = "rtl" : @dir = "ltr"
      I18n.with_locale(params[:lang] || I18n.default_locale, &action)
    end

    def default_url_options
      { lang: I18n.locale }
    end

    def cud_request?
      # CUD : Create, Update, Delete
      request.method == "GET" ? false : true
    end
end
