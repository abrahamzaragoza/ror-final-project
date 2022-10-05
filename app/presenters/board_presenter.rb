# frozen_string_literal: true

class BoardPresenter
  include ActionView::Helpers::TextHelper

  def initialize(board)
    @board = board
  end

  def humanized_list_count
    "This board has #{pluralize(@board.task_lists.all.count, 'list')}."
  end

  def visibility_badge_color
    {
      'public' => 'bg-success',
      'private' => 'bg-dark'
    }[@board.visibility]
  end
end
