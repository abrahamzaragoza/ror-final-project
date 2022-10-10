# frozen_string_literal: true

class SendBoardDeleteEmailJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)
    mail = UsersMailer.board_delete_email(user.id)
    mail.deliver_later
  end
end
