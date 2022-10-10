# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'wematchjs@gmail.com'
  layout 'mailer'
end
