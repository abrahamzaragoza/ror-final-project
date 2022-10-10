# frozen_string_literal: true

=begin
NOTE: Don't do repetitive stuff.
Extract it as a method.
Seems a little repetitive to me. 
Modularize stuff. 
=end

module FlashMessage
  include ActiveSupport::Concern

  private

  def flash_and_render(type, msg, route)
    flash[type] = msg
    render route
  end

  def flash_and_redirect_to(type, msg, route)
    flash[type] = msg
    redirect_to route
  end
end
