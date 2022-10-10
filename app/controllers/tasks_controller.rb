# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_task_list, only: %i[new create]
  grant(
    user: :all,
    manager: :all,
    admin: :all
  )

  def show
    @task_user = TaskUser.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def index; end

  def new
    @task = Task.new
  end

  def edit
    @list = TaskList.find(@task.task_list_id)
  end

  def create
    @task = Task.new(task_params)
    @task.author = current_user
    if @task.save
      flash_and_redirect_to(:notice, 'Task was created successfully.', board_path(boards_path))
    else
      flash_and_render(:alert, 'There was an error creating your task.', :new)
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
    params.require(:task).permit(%i[title started_at finished_at doing_time justification details task_list_id
                                    author_id])
  end

  def boards_path
    @task_list.board_id
  end

  def set_unassigned_users
    @users = User.where
  end
end
