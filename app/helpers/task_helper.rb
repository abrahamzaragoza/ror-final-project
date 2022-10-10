# frozen_string_literal: true

module TaskHelper
  def created_at_format(time)
    time.strftime('%m/%d/%Y %k:%M') 
  end
end
