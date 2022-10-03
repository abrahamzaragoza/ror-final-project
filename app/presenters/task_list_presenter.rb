# frozen_string_literal: true

class TaskListPresenter
  def initialize(list)
    @list = list
  end

  def priotity_badge_color
    {
      'low' => 'text-bg-secondary',
      'normal' => 'text-bg-success',
      'important' => 'text-bg-warning',
      'critical' => 'text-bg-danger'
    }[@list.priority]
  end
end
