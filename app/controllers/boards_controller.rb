# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :set_board, only: %i[show edit update destroy]
  grant(
    user: %i[show index],
    manager: :all,
    admin: :all
  )

  def show; end

  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def edit; end

  def create
    @board = Board.new(board_params)
    @board.owner = current_user
    if current_user.can_create_board? && @board.save
      flash_and_redirect_to(:notice, 'Board has been created successfully', @board)
    else
      flash_and_render(:alert, 'There was an error creating your board.', :new)
    end
  end

  def update
    return unless @board.update(board_params)

    flash_and_redirect_to(:notice, 'Board was updated successfully.', @board)
  end

  def destroy
    @board.destroy
    redirect_to boards_path
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(%i[title visibility owner_id])
  end
end
