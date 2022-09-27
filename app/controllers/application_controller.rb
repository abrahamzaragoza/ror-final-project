# frozen_string_literal: true

require_relative 'concerns/flash_messages_concern'

class ApplicationController < ActionController::Base
  include FlashMessage

  before_action :authenticate_user!
end
