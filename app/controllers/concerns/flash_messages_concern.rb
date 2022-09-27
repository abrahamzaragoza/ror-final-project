# frozen_string_literal: true

module FlashMessage
  include ActiveSupport::Concern

  private

  def flash_and_redirect_to(type, msg, route)
    flash[type] = msg
    redirect_to route
  end
end
