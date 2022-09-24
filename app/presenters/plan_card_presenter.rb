# frozen_string_literal: true

class PlanCardPresenter
  include ActionView::Helpers::TextHelper

  def initialize(plan)
    @plan = plan
  end

  def pluralize_plan_duration_in_months
    @plan.plan_duration > 1 ? pluralize(@plan.plan_duration, 'month') : 'month'
  end
end
