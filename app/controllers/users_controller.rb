class UsersController < ApplicationController
  grant(
    user: :all
  )
  def show
    @user = User.find(params[:id])
  end
end
