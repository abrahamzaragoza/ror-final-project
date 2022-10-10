# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  def profile_update_email(user_id)
    @user = User.find(user_id)

    mail(
      to: @user.email,
      subject: 'Account details updated'
    ) do |f|
      f.text
      f.html
    end
  end

  def board_delete_email(user_id)
    @user = User.find(user_id)

    mail(
      to: @user.email,
      subject: 'Board successfully removed'
    ) do |f|
      f.text
      f.html
    end
  end
end
