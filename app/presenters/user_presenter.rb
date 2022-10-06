# frozen_string_literal: true

class UserPresenter
  def initialize(user)
    @user = user
  end

  def security_update_status
    {
      true => 'suscribed',
      false => 'unsuscribed'
    }[@user.security_updates]
  end

  def security_update_color
    {
      true => 'green',
      false => 'red'
    }[@user.security_updates]
  end
end
