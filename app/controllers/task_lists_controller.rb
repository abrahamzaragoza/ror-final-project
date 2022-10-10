# frozen_string_literal: true

class TaskListsController < ApplicationController
  before_action :set_task_list, only: %i[show edit update destroy]
  before_action :set_board, only: %i[new create]
  grant(
    user: :all,
    manager: :all,
    admin: :all
  )

  def new
    @task_list = TaskList.new
  end

  def edit; end

  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.board_id = params[:board_id]
    # this able_to_create_list should have been added
    # into the model. 
    # please remember. Fat Model, Skinny Controller. 
    #before save and throwing an error while returning
    # false in the before_save 
    # or also, a custom validation would have been enough
    if @board.able_to_create_list? && @task_list.save
      flash_and_redirect_to(:notice, 'List has been created successfully', boards_path)
    else
      flash_and_render(:alert, 'There was an error creating your list.', :new)
    end
  end

  def update
    return unless @task_list.update(task_list_params)

    flash_and_redirect_to(:notice, 'List was updated successfully.', boards_path)
  end

  def destroy
    @board = Board.find(@task_list.board_id)
    @task_list.destroy
    redirect_to board_path(@board)
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

  def boards_path
    board_path(@task_list.board_id)
  end
end
