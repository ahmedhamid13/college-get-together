# frozen_string_literal: true

module Auth::UserRoles
  def authenticate_current_user
    current_user ? true : unauthorize_action
  end

  def authenticate_admin!
    if authenticate_current_user && current_user&.user_role != "admin"
      forbidden_action
    end
  end

  def authenticate_premium!
    if authenticate_current_user && current_user&.user_role && !["admin", "premium"].include?(current_user.user_role)
      forbidden_action
    end
  end

  def authenticate_normal!
    if authenticate_current_user && current_user&.user_role && !["admin", "normal"].include?(current_user.user_role)
      forbidden_action
    end
  end

  def unauthorize_action
    # redirect_to unauthorized_user_path and return false
  end

  def forbidden_action
    # redirect_to forbidden_user_path and return false
  end
end
