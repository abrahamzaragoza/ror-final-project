# frozen_string_literal: true

require_relative 'concerns/flash_messages_concern'

class ApplicationController < ActionController::Base
  include FlashMessage

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :authorization_tier)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :password, :current_password)
    end
  end
end
