# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_task_list, only: %i[new create]

  def show; end

  def index; end

  def new
    @task = Task.new
  end

  def edit
    @list = TaskList.find(@task.task_list_id)
  end

  def create
    @task = Task.new(task_params)
    # @task.task_list_id = params[:task_list_id]
    if @task.save
      flash_and_redirect_to(:notice, 'Task was created successfully.', board_path(boards_path))
    else
      render 'new'
    end
  end

  def update
    return unless @task.update(task_params)

    flash_and_redirect_to(:notice, 'Task was updated successfully.', @task)
  end

  def destroy
    @task_list = TaskList.find(@task.task_list_id)
    @task.destroy
    redirect_to board_path(boards_path)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_task_list
    @task_list = TaskList.find(params[:task_list_id])
  end

  def task_params
    params.require(:task).permit(%i[title started_at finished_at doing_time justification details task_list_id])
  end

  def boards_path
    @task_list.board_id
  end
end
