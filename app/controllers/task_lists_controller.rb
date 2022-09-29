class TaskListsController < ApplicationController
  before_action :set_task_list, only: [:show]
  before_action :set_board, only: [:new]

  def show
  end

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.board_id = params[:board_id]
    if @task_list.save
      flash_and_redirect_to(:notice, 'List has been created successfully', board_path(@task_list.board_id))
    else
      render 'new'
    end
  end

  private

  def set_task_list
    @task_list = TaskList.find(params[:id])
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def task_list_params
    params.require(:task_list).permit(%i[name color priority board_id])
  end
end
