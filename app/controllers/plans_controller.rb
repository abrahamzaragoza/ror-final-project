# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :set_plan, only: %i[edit update destroy]
  grant(
    manager: :index,
    admin: :all
  )

  def show; end

  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def edit; end

  def create
    if can_create_plan?
      @plan = Plan.new(plan_params)
      if @plan.save
        flash_and_redirect_to(:notice, 'Plan was created successfully.', plans_path)
      else
        flash[:alert] = "There was an error creating your plan."
        render 'new'
      end
    else
      flash_and_redirect_to(:alert, 'The maximum amount of plans have been reached.', plans_path)
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
