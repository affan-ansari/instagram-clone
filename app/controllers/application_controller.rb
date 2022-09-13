# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :image, :is_public)
    end
  end

  def set_search
    @q = User.search(params[:q])
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to(request.referer || root_path)
  end
end
