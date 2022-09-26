# frozen_string_literal: true

class FlashMessagesPresenter
  def initialize(type)
    @type = type
  end

  def flash_type_class
    @type == 'notice' ? 'success' : 'danger'
  end
end
