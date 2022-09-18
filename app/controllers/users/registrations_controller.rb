# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def update
      if current_user.valid_password?(params[:user][:current_password])
        super
      else
        current_user.errors.add(:current_password, 'is invalid')
        render 'edit'
      end
    end
  end
end
