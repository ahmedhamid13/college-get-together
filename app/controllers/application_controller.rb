# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Auth::UserRoles

  protect_from_forgery with: :exception
  around_action :switch_locale
  before_action :set_theme_color, :set_user_type
  before_action :authenticate_user!, if: :cud_request?

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
