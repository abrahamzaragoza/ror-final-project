# frozen_string_literal: true

class TaskListPresenter

  def initialize(list)
    @list = list
  end

  def priotity_badge_color
    case @list.priority
    when 'low'
      'text-bg-secondary'
    when 'normal'
      'text-bg-success'
    when 'important'
      'text-bg-warning'
    when 'critical'
      'text-bg-danger'
    end
  end
end
