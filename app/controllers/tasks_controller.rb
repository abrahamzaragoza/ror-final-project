class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def show; end

  def index; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    if @task.save
      raise_flash_and_redirect_to(:notice, 'Task was created successfully.', @task)
    else
      render 'new'
    end
  end

  def update
    return unless @task.update(task_params)

    raise_flash_and_redirect_to(:notice, 'Task was updated successfully.', @task)
  end

  def destroy; end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :started_at, :finished_at, :doing_time, :justification, :details)
  end
end
