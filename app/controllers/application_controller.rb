class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url 
      end
    end
    
    def admin_user
      redirect_to(root_url) unless current_user && current_user.status_admin?
    end

    def writer_user
      redirect_to(root_url) unless current_user && current_user.status_writer?
    end

    def moderator_user
      redirect_to(root_url) unless current_user && current_user.status_moderator?
    end
end
