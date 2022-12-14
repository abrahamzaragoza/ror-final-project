# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :set_plan, only: %i[show edit update destroy]
  grant(
    manager: %i[index show],
    admin: :all
  )

  def index
    @plans = Plan.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @plan = Plan.new
  end

  def edit; end

  def create
    @plan = Plan.new(plan_params)
    if can_create_plan? && @plan.save
      flash_and_redirect_to(:notice, 'Plan was created successfully.', plans_path)
    else
      flash_and_render(:alert, 'There was an error creating your plan.', :new)
    end
  end

  def update
    return unless @plan.update(plan_params)

    flash_and_redirect_to(:notice, 'Plan was updated successfully.', plans_path)
  end

  def destroy
    @plan.destroy
    redirect_to plans_path
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:plan_name, :price_cents, :price_currency, :plan_members, :plan_duration)
  end

  def can_create_plan?
    Plan.count < 3
  end
end
