# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :password_confirmation, :image, :is_public)
    end
  end

  def set_search
    @q = User.search(params[:q])
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to(request.referer || authenticated_root_path)
  end

  def record_not_found
    flash[:alert] = 'Record does not exist'
    redirect_to(request.referer || authenticated_root_path)
  end

  def record_not_destroyed
    flash[:alert] = 'Record was not destroyed'
    redirect_to(request.referer || authenticated_root_path)
  end
end
