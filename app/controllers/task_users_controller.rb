# frozen_string_literal: true

class TaskUsersController < ApplicationController
  before_action :set_task
  grant(
    user: :all
  )

  def new
    @task_user = TaskUser.new
  end

  def create
    @task_user = TaskUser.new(task_user_params)
    @task_user.task_id = params[:task_id]
    if @task_user.save
      flash_and_redirect_to(:notice, 'User has benn added successfully.', task_path(@task_user.task_id))
    else
      flash_and_render(:alert, 'There was an error adding the user.', :new)
    end
  end

  private

  def task_user_params
    params.require(:task_user).permit(%i[task_id user_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end
end
