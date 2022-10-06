# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :restrict_access
  grant(
    user: :all
  )
  def show
    @user = User.find(params[:id])
  end

  private

  def restrict_access
    return if current_user.id == params[:id].to_i

    flash_and_redirect_to(:alert, 'You can only enter you own profile', root_path)
  end
end
