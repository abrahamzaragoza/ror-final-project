# frozen_string_literal: true

require_relative 'concerns/flash_messages_concern'

class ApplicationController < ActionController::Base
  include AuthorizedPersona::Authorization
  include FlashMessage

  authorize_persona class_name: 'User'

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :authorization_tier, :security_updates)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :password, :current_password, :security_updates)
    end
  end
end
