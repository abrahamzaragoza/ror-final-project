class TaskListsController < ApplicationController
  before_action :set_task_list, only: [:show]

  def show
  end

  private

  def set_task_list
    @task_list = TaskList.find(params[:id])
  end
end
