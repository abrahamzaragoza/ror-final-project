# frozen_string_literal: true

class SendUpdateEmailJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)
    mail = UsersMailer.profile_update_email(user.id)
    mail.deliver_later
  end
end
